# @provides MotionKit::ConstraintsTarget
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

    def ==(value)
      if value.is_a?(ConstraintsTarget)
        super
      else
        @view == value
      end
    end

    def apply_all_constraints(layout, target)
      @constraints.map do |mk_constraint|
        mk_constraint.resolve_all(layout, target).map do |constraint|
          if mk_constraint.active
            mk_constraint.common_ancestor.addConstraint(constraint)
          end
          constraint
        end
      end.flatten
    end

  end

end
