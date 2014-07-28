# @requires MotionKit::NSViewLayout
module MotionKit
  class NSViewLayout

    def constraints(add_to_view=nil, &block)
      add_to_view ||= target
      if add_to_view.is_a?(Symbol)
        add_to_view = self.get_view(add_to_view)
      end
      add_to_view.setTranslatesAutoresizingMaskIntoConstraints(false)

      constraints_target = ConstraintsTarget.new(add_to_view)
      deferred(constraints_target) do
        context(constraints_target, &block)
        constraints_target.apply_all_constraints(self, add_to_view)
      end
    end

  end

  class Layout

    def constraints(add_to_view=nil, &block)
      if has_context?
        apply(:constraints, add_to_view, &block)
      else
        context(self.view) do
          constraints(add_to_view, &block)
        end
      end
    end

  end
end
