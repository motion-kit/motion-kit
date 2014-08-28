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

    def initialize(args={})
      # @layout is the object we look in for style methods
      @layout = nil
      # the Layout object that implements custom style methods. Leave this as nil
      # in the initializer.
      @layout_delegate = nil
      @layout_state = :initial
      # You can set a root view by using .new(root: some_view)
      # Explicit roots will not have a strong reference from
      # MotionKit, so retain one yourself from your controller
      # or other view to prevent deallocation.
      @preset_root = args[:root]
    end

    def set_parent_layout(layout)
      @layout = WeakRef.new(layout)
    end

    def parent_layout
      @layout || self
    end

    def is_parent_layout?
      @layout.nil? || @layout == self
    end

    def has_context?
      if is_parent_layout?
        !!@context
      else
        parent_layout.has_context?
      end
    end

    def target
      if is_parent_layout?
        # only the "root layout" instance is allowed to change the context.
        # if there isn't a context set, try and create a root instance; this
        # will fail if we're not in a state that allows the root to be created
        @context ||= create_default_root_context
      else
        # child layouts get the context from the root layout
        parent_layout.target
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
    def context(new_target, &block)
      return new_target unless block
      # this little line is incredibly important; the context is only set on
      # the top-level Layout object.
      return parent_layout.context(new_target, &block) unless is_parent_layout?

      if new_target.is_a?(Symbol)
        new_target = self.get_view(new_target)
      end

      context_was, parent_was, delegate_was = @context, @parent, @layout_delegate

      prev_should_run = @should_run_deferred
      if @should_run_deferred.nil?
        @should_run_deferred = true
      else
        @should_run_deferred = false
      end
      @parent = MK::Parent.new(context_was)
      @context = new_target
      @context.motion_kit_meta[:delegate] ||= Layout.layout_for(@context.class)
      @layout_delegate = @context.motion_kit_meta[:delegate]
      if @layout_delegate
        @layout_delegate.set_parent_layout(parent_layout)
      end
      yield
      @layout_delegate, @context, @parent = delegate_was, context_was, parent_was
      if @should_run_deferred
        run_deferred(new_target)
      end
      @should_run_deferred = prev_should_run

      new_target
    end

    # Blocks passed to `deferred` are run at the end of a "session", usually
    # after a call to Layout#layout.
    def deferred(context=nil, &block)
      context ||= @context
      return parent_layout.add_deferred_block(context, &block)
    end

    # Only intended for private use
    def add_deferred_block(context, &block)
      context ||= @context
      if context.nil? && @assign_root
        context ||= self.create_default_root_context
      end
      raise InvalidDeferredError.new('deferred must be run inside of a context') unless context
      raise ArgumentError.new('Block required') unless block

      self.deferred_blocks << [context, block]

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

    def objc_version(method_name, args)
      if method_name.count(':') > 1
        objc_method_name = method_name
        objc_method_args = [args[0]].concat args[1].values
      elsif args.length == 2 && args[1].is_a?(Hash) && !args[1].empty?
        objc_method_name = "#{method_name}:#{args[1].keys.join(':')}:"
        objc_method_args = [args[0]].concat args[1].values
      else
        objc_method_name = nil
        objc_method_args = nil
      end
      return objc_method_name, objc_method_args
    end

    def ruby_version(method_name)
      if method_name.count(':') > 1
        method_name.split(':').first
      else
        method_name
      end
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

      objc_method_name, objc_method_args = objc_version(method_name, args)
      ruby_method_name = ruby_version(method_name)

      @layout_delegate ||= Layout.layout_for(target.class)
      if @layout_delegate
        @layout_delegate.set_parent_layout(parent_layout)
        if objc_method_name && @layout_delegate.respond_to?(objc_method_name)
          return @layout_delegate.send(objc_method_name, *objc_method_args, &block)
        elsif @layout_delegate.respond_to?(ruby_method_name)
          return @layout_delegate.send(ruby_method_name, *args, &block)
        end
      end

      if block
        apply_with_context(method_name, *args, &block)
      else
        apply_with_target(method_name, *args, &block)
      end
    end

    def apply_with_context(method_name, *args, &block)
      objc_method_name, objc_method_args = objc_version(method_name, args)
      ruby_method_name = ruby_version(method_name)

      if objc_method_name && target.respond_to?(objc_method_name)
        new_context = target.send(objc_method_name, *objc_method_args)
        self.context(new_context, &block)
      elsif target.respond_to?(ruby_method_name)
        new_context = target.send(ruby_method_name, *args)
        self.context(new_context, &block)
      elsif ruby_method_name.include?('_')
        objc_name = MotionKit.objective_c_method_name(ruby_method_name)
        self.apply(objc_name, *args, &block)
      else
        raise ApplyError.new("Cannot apply #{ruby_method_name.inspect} to instance of #{target.class.name}")
      end
    end

    def apply_with_target(method_name, *args, &block)
      objc_method_name, objc_method_args = objc_version(method_name, args)
      ruby_method_name = ruby_version(method_name)

      setter = MotionKit.setter(ruby_method_name)
      assign = "#{ruby_method_name}="

      # The order is important here.
      # - unchanged method name if no args are passed (e.g. `layer`)
      # - setter (`setLayer(val)`)
      # - assign (`layer=val`)
      # - unchanged method name *again*, because many Ruby classes provide a
      #   combined getter/setter (`layer(val)`)
      # - lastly, try again after converting to camelCase
      if objc_method_name && target.respond_to?(objc_method_name)
        target.send(objc_method_name, *objc_method_args, &block)
      elsif args.empty? && target.respond_to?(ruby_method_name)
        target.send(ruby_method_name, *args, &block)
      elsif target.respond_to?(setter)
        target.send(setter, *args, &block)
      elsif target.respond_to?(assign)
        target.send(assign, *args, &block)
      elsif target.respond_to?(ruby_method_name)
        target.send(ruby_method_name, *args, &block)
      # UIAppearance classes are a whole OTHER thing; they never return 'true'
      elsif target.is_a?(MotionKit.appearance_class)
        target.send(setter, *args, &block)
      # Finally, try again with camel case if there's an underscore.
      elsif method_name.include?('_')
        objc_name = MotionKit.objective_c_method_name(method_name)
        self.apply(objc_name, *args, &block)
      else
        target.send(setter, *args, &block)
      end
    end

    class << self

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
            retval = apply(method_name, *args, &block)
            target.motion_kit_meta[running_name] = false
            return retval
          end
        end
      end

    end

  protected

    def preset_root
      # Set in the initializer
      # TreeLayout.new(root: some_view)
      @preset_root
    end

  end



end
