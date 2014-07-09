# @requires MotionKit::UIViewLayout
module MotionKit
  class UIViewLayout

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

    # Ensure we always have a context in this method; makes it easier to define
    # constraints in an `add_constraints` method.
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
