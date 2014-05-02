# @requires MotionKit::NSViewLayout
module MotionKit
  class NSViewLayout

    def constraints(&block)
      deferred do
        constraints = ConstraintsTarget.new(target)
        context(constraints, &block)
        constraints.resolve_all(self, target)
      end
    end

  end
end
