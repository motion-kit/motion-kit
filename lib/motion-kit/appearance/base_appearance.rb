# @provides MotionKit::BaseAppearance
module MotionKit
  class BaseAppearance
    def style(*targets, &block)
      targets.each do |target|
        context_stack.push target
        block.call
        context_stack.pop
      end
    end

    # This is used to apply attributes explicitly to the
    # target's `appearance` object, in context if applicable.
    # @example
    #   def build
    #     style UIButton do
    #       appearance.setTitleColor UIColor.blackColor, forState:UIControlStateNormal
    #     end
    #   end
    def appearance
      if context_stack.length == 1
        context_stack.last.appearance
      else
        context_stack.last.appearanceWhenContainedIn(context_stack[0..-2])
      end
    end

    private

    def context_stack
      @context_stack ||= []
    end

  end
end
