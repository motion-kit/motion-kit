motion_require 'uiview_layout'

module MotionKit
  class UIViewLayout

    def constraints(&block)
      deferred do
        constraints = ConstraintsTarget.new
        context(constraints, &block)
        constraints.resolve_all(self.view)
      end
    end

  end
end
