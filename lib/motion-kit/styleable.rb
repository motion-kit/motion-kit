module MotionKit
  # This module is responsible for the "method magic" of MotionKit.  Very few
  # methods are defined on Layout, and any unknown methods are delegated to the
  # 'apply' method of Styleable, which accepts a method name, arguments, and an
  # optional block to set the new context.
  module Styleable
    # this ivar name is not set in stone - 'v' as an alias, is.
    attr :styleable_context
    alias v styleable_context

    # Sets the context, calls the block, restores the previous context.  We
    # might want to add 'parent' support (to call methods on the original
    # context, for example). Just change 'context_was' to an appropriately
    # named instance variable.
    #
    # This method is part of the public API, you can pass in any object to have
    # it become the 'context'.
    #
    # Example:
    #     def table_view_style
    #       # if you need to check the return value
    #       content = contentView
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
    #         corner_radius 5
    #       end
    #     end
    def context(target, &block)
      target_was = @styleable_context
      @styleable_context = target
      self.instance_exec(&block) if block
      @styleable_context = target_was
      return target
    end

    # Tries to call the setter (`foo 'value'` => `view.setFoo('value')`), or
    # assignment method (`foo 'value'` => `view.foo = 'value'`), or if a block
    # is given, then the object returned by 'method_name' is assigned as the new
    # context, and the block is executed.
    #
    # You can call this method directly, but usually it is called via
    # method_missing.
    def apply(method_name, *args, &block)
      raise ApplyError.new("No context defined in Styleable#apply(#{method_name.inspect})") unless @styleable_context

      target = @styleable_context
      method_name = method_name.to_s
      raise ApplyError.new("Cannot apply #{method_name.inspect} to instance of #{target.class.name}") if method_name.length == 0

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
      # and appearance classes are a whole OTHER thing
      elsif target.is_a?(MotionKit.appearance_class)
        return target.send(setter, *args)
      # try again with camel case if there's an underscore
      elsif method_name.include?('_')
        objc_name = MotionKit.objective_c_method_name(method_name)
        return self.apply(objc_name, *args)
      # failure
      else
        raise ApplyError.new("Cannot apply #{method_name.inspect} to instance of #{target.class.name}")
      end
    end

    # This is the main entry point for the 'apply' method. If you have assigned
    # a context (and MotionKit does this for you most of the time you'd need to)
    # you can apply styling methods just by applying the method to 'self'
    #
    # Example:
    #     def login_button
    #       title 'Login'
    #       text_color UIColor.whiteColor
    #       background_color UIColor.clearColor
    #     end
    def method_missing(method_name, *args, &block)
      # only allow 'method_missing' if we've setup a context, otherwise we
      # should just raise NoMethodError (via super)
      if @styleable_context
        begin
          return self.apply(method_name, *args, &block)
        rescue ApplyError
          raise NoMethodError.new("No setter or method called #{method_name.inspect}")
        end
      else
        super
      end
    end

  end
end
