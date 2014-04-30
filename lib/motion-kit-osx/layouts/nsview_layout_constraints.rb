motion_require 'nsview_layout'

module MotionKit
  class NSViewLayout

    def constraints(&block)
      deferred do
        constraints = ConstraintsTarget.new
        context(constraints, &block)
        constraints.resolve_all(self.view)
      end
    end

  end
end
