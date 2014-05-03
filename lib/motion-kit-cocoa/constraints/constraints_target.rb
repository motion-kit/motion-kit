module MotionKit
  class ConstraintsTarget
    attr :view

    def initialize(view)
      @view = view
      @constraints = []
    end

    def add_constraints(constraints)
      @constraints.concat(constraints)
    end

    def apply_all_constraints(layout, target)
      @constraints.map do |mk_constraint|
        mk_constraint.resolve_all(layout, target).map do |constraint|
          base_view_class = MotionKit.base_view_class

          if constraint.firstItem.is_a?(base_view_class) && constraint.secondItem.is_a?(base_view_class)
            common_ancestor = nil

            ancestors = [constraint.firstItem]
            parent_view = constraint.firstItem
            while parent_view = parent_view.superview
              ancestors << parent_view
            end

            current_view = constraint.secondItem
            while current_view
              if ancestors.include? current_view
                common_ancestor = current_view
                break
              end
              current_view = current_view.superview
            end

            unless common_ancestor
              raise NoCommonAncestorError.new("No common ancestors between #{constraint.firstItem} and #{constraint.secondItem}")
            end
          else
            common_ancestor = constraint.firstItem
          end

          common_ancestor.addConstraint(constraint)
          constraint
        end
      end.flatten
    end

  end

end
