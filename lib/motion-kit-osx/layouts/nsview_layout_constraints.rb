# @requires MotionKit::NSViewLayout
module MotionKit
  class NSViewLayout

    def constraints(view=nil, &block)
      view ||= target
      if view.is_a?(Symbol)
        view = self.get(view)
      end
      view.setTranslatesAutoresizingMaskIntoConstraints(false)

      constraints_target = ConstraintsTarget.new(view)
      deferred(constraints_target) do
        context(constraints_target, &block)
        constraints_target.apply_all_constraints(self, view)
      end
    end

  end

  class Layout

    def constraints(view=nil, &block)
      if has_context?
        apply(:constraints, view, &block)
      else
        context(self.view) do
          constraints(view, &block)
        end
      end
    end

  end
end
