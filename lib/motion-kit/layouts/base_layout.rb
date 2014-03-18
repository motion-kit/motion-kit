module MotionKit
  # Abstract base class, responsible for "registration" of layout classes with
  # the class `targets` method.
  #
  # Very few methods are defined on BaseLayout, and any unknown methods are
  # delegated to the 'apply' method, which accepts a method name, arguments, and
  # an optional block to set the new context.
  #
  # The ViewLayout subclass defines methods that are appropriate for adding and
  # removing views to a view hierarchy.
  class BaseLayout

    class << self

      def target_klasses
        # We only want to return the *BaseLayout*'s target_klasses store, not
        # a subclass'.
        return BaseLayout.target_klasses unless self == BaseLayout
        @target_klasses ||= {}
      end

      def targets(klass=nil)
        if klass.nil?
          if self == BaseLayout
            nil
          else
            @targets || superclass.targets
          end
        else
          @targets = klass
          BaseLayout.target_klasses[klass] = self
          nil
        end
      end

      # Instantiates a new Layout instance using `layout` as the root-level layout
      def layout_for(layout, klass)
        target_klasses = BaseLayout.target_klasses

        # shave a little bit of time by caching the result of this klass/layout
        # lookup.
        @memoize ||= {}
        unless @memoize[klass]
          # go up the classes ancestors looking for a registered class. This is
          # how new subclasses can inherit an existing registered Layout from
          # one of its superclasses.
          while klass
            if registered_class = target_klasses[klass]
              break
            end
            klass = klass.superclass
          end
          return nil unless registered_class

          @memoize[klass] = registered_class
        end

        return @memoize[klass].new_child(layout)
      end

      def new_child(layout=nil)
        child = self.new
        child.set_layout(layout)
        return child
      end

    end

    attr :parent

    def initialize
      # if you're tempted to set @layout_delegate here - don't. In a ViewLayout,
      # we could instantiate a 'root' view that does *not* use the same Layout
      # as the current class. Leave the delegate as 'nil' so it can be created
      # in 'context'.

      # the object to look in for style methods
      @layout = self
      # the Layout object that implements custom style methods
      @layout_delegate = nil
      # this variable is almost always 'initial'. It is only set to :reapply
      # from the reapply! method. Makes sense when you consider the fact that
      # you can have arbitrary view-creation methods (other than 'layout'), and
      # they would be expected to support `initial/reapply` blocks as well.
      @layout_state = :initial
    end

    def set_layout(layout)
      @layout = layout && WeakRef.new(layout)
    end

    def target
      if @layout.nil? || @layout == self
        # only the "root layout" instance is allowed to change the context.
        # if there isn't a context set, try and create a root instance; this
        # will fail if we're not in a state that allows the root to be created
        @context ||= create_default_root_context
      else
        # child layouts get the context from the root layout
        @layout.target
      end
    end
    def v ; target ; end

    # Runs a block of code with a new object as the 'context'. Methods from the
    # Layout classes are applied to this target object, and missing methods are
    # delegated to a new Layout instance that is created based on the new
    # context.
    #
    # This method is part of the public API, you can pass in any object to have
    # it become the 'context'.
    #
    # Example:
    #     def table_view_style
    #       content = target.contentView
    #       if content
    #         context(content) do
    #           background_color UIColor.clearColor
    #         end
    #       end
    #
    #       # usually you use 'context' automatically via method_missing, by
    #       # passing a block to a method that returns an object. That object becomes
    #       # the new context.
    #       layer do
    #         # self is now a CALayerLayout instance
    #         corner_radius 5
    #       end
    #     end
    def context(target, &block)
      return target unless block
      # this little line is incredibly important; the context is only set on
      # the top-level Layout object.
      return @layout.context(target, &block) if @layout && @layout != self

      context_was = @context
      parent_was = @parent
      delegate_was = @layout_delegate

      @parent = MK::Parent.new(context_was)
      @context = target
      @context.motion_kit_meta[:delegate] ||= Layout.layout_for(@layout, @context.class)
      @layout_delegate = @context.motion_kit_meta[:delegate]
      yield
      @layout_delegate = delegate_was
      @context = context_was
      @parent = parent_was

      return target
    end

    # All missing methods get delegated to either the @layout_delegate or
    # applied to the context using one of the setter methods that `apply`
    # supports.
    def method_missing(method_name, *args, &block)
      self.apply(method_name, *args, &block)
    end

    # Tries to call the setter (`foo 'value'` => `view.setFoo('value')`), or
    # assignment method (`foo 'value'` => `view.foo = 'value'`), or if a block
    # is given, then the object returned by 'method_name' is assigned as the new
    # context, and the block is executed.
    #
    # You can call this method directly, but usually it is called via
    # method_missing.
    def apply(method_name, *args, &block)
      method_name = method_name.to_s
      raise ApplyError.new("Cannot apply #{method_name.inspect} to instance of #{target.class.name}") if method_name.length == 0

      target = self.target
      @layout_delegate ||= Layout.layout_for(@layout, target.class)
      if @layout_delegate.respond_to?(method_name)
        return @layout_delegate.send(method_name, *args, &block)
      end

      if block
        if target.respondsToSelector(method_name)
          new_context = target.send(method_name, *args)
          return self.context(new_context, &block)
        elsif method_name.include?('_')
          objc_name = MotionKit.objective_c_method_name(method_name)
          return self.apply(objc_name, *args, &block)
        else
          raise ApplyError.new("Cannot apply #{method_name.inspect} to instance of #{target.class.name}")
        end
      end

      # setters are not touched; just send the method as-is, and don't bother
      # with checking `method_name=`.
      if method_name =~ /^set[A-Z]/
        assign = nil
        setter = method_name + ':'
      else
        assign = method_name + '='
        setter = 'set' + method_name[0].capitalize + method_name[1..-1] + ':'
      end

      # the order of checking methods is important; Ruby classes can return
      # 'true' for `respond_to?('foo=')` even though `send('foo=')` will raise a
      # NoMethodError.

      # objc classes are the opposite
      if target.respondsToSelector(setter)
        return target.send(setter, *args)
      # ruby classes will probably define the attr_accessor, not a 'setFoo' method
      elsif assign && target.respond_to?(assign)
        return target.send(assign, *args)
      # it's possible this is a setter of the form `foo(value)`. We only call
      # this method if the arity is NOT 0, so getters are always avoided.
      # Unless args is empty, in which case we WANT to call the getter
      elsif target.respond_to?(method_name) && (target.method(method_name).arity != 0 || args.empty?)
        return target.send(method_name, *args)
      # UIAppearance classes are a whole OTHER thing; they never return 'true'
      elsif target.is_a?(MotionKit.appearance_class)
        return target.send(setter, *args)
      # Finally, try again with camel case if there's an underscore.
      elsif method_name.include?('_')
        objc_name = MotionKit.objective_c_method_name(method_name)
        return self.apply(objc_name, *args)
      # failure
      else
        raise ApplyError.new("Cannot apply #{method_name.inspect} to instance of #{target.class.name}")
      end
    end

  public

    # this last little "catch-all" method is helpful to warn against methods
    # that are defined already. Since magic methods are so important, this
    # warning can come in handy.
    def self.method_added(method_name)
      if self < BaseLayout && BaseLayout.method_defined?(method_name)
        NSLog("Warning! The method #{self.name}##{method_name} has already been defined on MotionKit::BaseLayout or one of its ancestors.")
      end
    end

  end

end
