# @provides MotionKit::BaseLayout
# @requires MotionKit::BaseLayoutClassMethods
module MotionKit
  # Abstract base class, responsible for "registration" of layout classes with
  # the class `targets` method.
  #
  # Very few methods are defined on BaseLayout, and any unknown methods are
  # delegated to the 'apply' method, which accepts a method name, arguments, and
  # an optional block to set the new context.
  #
  # The TreeLayout subclass defines methods that are appropriate for adding and
  # removing views to a view hierarchy.
  class BaseLayout
    # Class methods reside in base_layout_class_methods.rb
    extend BaseLayoutClassMethods

    attr :parent

    def initialize
      # @layout is the object we look in for style methods
      @layout = self
      # the Layout object that implements custom style methods. Leave this as nil
      # in the initializer.
      @layout_delegate = nil
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
      return @layout.context(target, &block) if @layout != self

      if target.is_a?(Symbol)
        target = self.get(target)
      end

      context_was, parent_was, delegate_was = @context, @parent, @layout_delegate

      was_top_level = @is_top_level
      if @is_top_level.nil?
        @is_top_level = true
      else
        @is_top_level = false
      end
      @parent = MK::Parent.new(context_was)
      @context = target
      @context.motion_kit_meta[:delegate] ||= Layout.layout_for(@layout, @context.class)
      @layout_delegate = @context.motion_kit_meta[:delegate]
      yield
      @layout_delegate, @context, @parent = delegate_was, context_was, parent_was
      if @is_top_level
        run_deferred(target)
      end
      @is_top_level = was_top_level

      target
    end

    # Blocks passed to `deferred` are run at the end of a "session", usually
    # after a call to Layout#layout.
    def deferred(&block)
      if @layout != self
        return @layout.add_deferred_block(self, &block)
      else
        return self.add_deferred_block(self, &block)
      end
    end

    # Only intended for private use
    def add_deferred_block(layout, &block)
      raise InvalidDeferredError.new('deferred must be run inside of a context') if @is_top_level.nil?
      raise ArgumentError.new('Block required') unless block

      self.deferred_blocks << [@context, block]

      self
    end

    # Only intended for private use
    def deferred_blocks
      @deferred_blocks ||= []
    end

    # Only intended for private use
    def run_deferred(top_level_context)
      deferred_blocks = self.deferred_blocks
      @deferred_blocks = nil

      deferred_blocks.each do |target, block|
        context(target, &block)
      end

      if @deferred_blocks
        run_deferred(top_level_context)
      end
    end

    # @example
    #     def login_button_style
    #       frame [[0, 0], [100, 20]]
    #       title 'Login'
    #     end
    #
    # Methods that style the view start out as missing methods. This just calls
    # 'apply', which searches for the method in the delegate
    # (`@layout_delegate`) or using inspection (`respond_to?(:setFoo)`).
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

      # if there is no target, than we should raise the NoMethodError; someone
      # called a method on the layout directly.
      begin
        target = self.target
      rescue NoContextError => e
        raise NoMethodError.new("undefined method `#{method_name}' for #{self}:#{self.class}", method_name)
      end

      if args.length == 2 && args[1].is_a?(Hash) && !args[1].empty?
        long_method_name = "#{method_name}:#{args[1].keys.join(':')}:"
        long_method_args = [args[0]].concat args[1].values
      else
        long_method_name = nil
        long_method_args = nil
      end

      @layout_delegate ||= Layout.layout_for(@layout, target.class)
      if long_method_name && @layout_delegate.respond_to?(long_method_name)
        return @layout_delegate.send(long_method_name, *long_method_args, &block)
      elsif @layout_delegate.respond_to?(method_name)
        return @layout_delegate.send(method_name, *args, &block)
      end

      if block
        apply_with_context(method_name, *args, &block)
      else
        apply_with_target(method_name, *args, &block)
      end
    end

    def apply_with_context(method_name, *args, &block)
      if args.length == 2 && args[1].is_a?(Hash) && !args[1].empty?
        long_method_name = "#{method_name}:#{args[1].keys.join(':')}:"
        long_method_args = [args[0]].concat args[1].values
      else
        long_method_name = nil
        long_method_args = nil
      end

      if long_method_name && target.respond_to?(long_method_name)
        new_context = target.send(long_method_name, *long_method_args)
        self.context(new_context, &block)
      elsif target.respond_to?(method_name)
        new_context = target.send(method_name, *args)
        self.context(new_context, &block)
      elsif method_name.include?('_')
        objc_name = MotionKit.objective_c_method_name(method_name)
        self.apply(objc_name, *args, &block)
      else
        raise ApplyError.new("Cannot apply #{method_name.inspect} to instance of #{target.class.name}")
      end
    end

    def apply_with_target(method_name, *args, &block)
      setter = MotionKit.setter(method_name)
      assign = "#{method_name}="
      if args.length == 2 && args[1].is_a?(Hash) && !args[1].empty?
        long_method_name = "#{method_name}:#{args[1].keys.join(':')}:"
        long_method_args = [args[0]].concat args[1].values
      else
        long_method_name = nil
        long_method_args = nil
      end

      # The order is important here.
      # - unchanged method name if no args are passed (e.g. `layer`)
      # - setter (`setLayer(val)`)
      # - assign (`layer=val`)
      # - unchanged method name *again*, because many Ruby classes provide a
      #   combined getter/setter (`layer(val)`)
      # - lastly, try again after converting to camelCase
      if long_method_name && target.respond_to?(long_method_name)
        target.send(long_method_name, *long_method_args, &block)
      elsif args.empty? && target.respond_to?(method_name)
        target.send(method_name, *args, &block)
      elsif target.respond_to?(setter)
        target.send(setter, *args, &block)
      elsif target.respond_to?(assign)
        target.send(assign, *args, &block)
      elsif target.respond_to?(method_name)
        target.send(method_name, *args, &block)
      # UIAppearance classes are a whole OTHER thing; they never return 'true'
      elsif target.is_a?(MotionKit.appearance_class)
        target.send(setter, *args, &block)
      # Finally, try again with camel case if there's an underscore.
      elsif method_name.include?('_')
        objc_name = MotionKit.objective_c_method_name(method_name)
        self.apply(objc_name, *args)
      else
        target.send(setter, *args, &block)
        # raise ApplyError.new("Cannot apply #{method_name.inspect} to instance of #{target.class.name} (from #{@layout_delegate && @layout_delegate.class})")
      end
    end

  public

    class << self

      def override_start
        @allow_all_override = true
      end

      def override_stop
        @allow_all_override = false
      end

      def overrides(method_name)
        overridden_methods << method_name
      end

      def overridden_methods
        @overridden_methods ||= []
      end

      # Prevents infinite loops when methods that are defined on Object/Kernel
      # are not properly delegated to the target.
      def delegate_method_fix(method_name)
        running_name = "motion_kit_is_calling_#{method_name}"
        define_method(method_name) do |*args, &block|
          if target.motion_kit_meta[running_name]
            if block
              apply_with_context(method_name, *args, &block)
            else
              apply_with_target(method_name, *args)
            end
          else
            target.motion_kit_meta[running_name] = true
            retval = apply(method_name, *args)
            target.motion_kit_meta[running_name] = false
            return retval
          end
        end
      end

      # this last little "catch-all" method is helpful to warn against methods
      # that are defined already. Since magic methods are so important, this
      # warning can come in handy.
      def method_added(method_name)
        return if @allow_all_override

        if self < BaseLayout && BaseLayout.method_defined?(method_name)
          if overridden_methods.include?(method_name)
            overridden_methods.delete(method_name)
          else
            NSLog("Warning! The method #{self.name}##{method_name} has already been defined on MotionKit::BaseLayout or one of its ancestors.")
          end
        end
      end

    end


  end

end
