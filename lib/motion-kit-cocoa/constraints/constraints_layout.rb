# @provides MotionKit::ConstraintsLayout
# @requires MotionKit::BaseLayout
# @requires MotionKit::ConstraintsTarget
module MotionKit
  class ConstraintsLayout < BaseLayout
    targets ConstraintsTarget

    def first(name)
      ConstraintPlaceholder.new(:first, name)
    end

    def last(name)
      ConstraintPlaceholder.new(:last, name)
    end

    def nth(name, value)
      ConstraintPlaceholder.new(:nth, name, value)
    end

    def x(value=nil)
      target_constraint(:left, :equal, value)
    end
    alias left x

    def min_x(value=nil)
      target_constraint(:left, :gte, value)
    end
    alias min_left min_x

    def max_x(value=nil)
      target_constraint(:left, :lte, value)
    end
    alias max_left max_x

    def leading(value=nil)
      target_constraint(:leading, :equal, value)
    end

    def min_leading(value=nil)
      target_constraint(:leading, :gte, value)
    end

    def max_leading(value=nil)
      target_constraint(:leading, :lte, value)
    end

    def center_x(value=nil)
      target_constraint(:center_x, :equal, value)
    end

    def min_center_x(value=nil)
      target_constraint(:center_x, :gte, value)
    end

    def max_center_x(value=nil)
      target_constraint(:center_x, :lte, value)
    end

    def right(value=nil)
      target_constraint(:right, :equal, value)
    end

    def min_right(value=nil)
      target_constraint(:right, :gte, value)
    end

    def max_right(value=nil)
      target_constraint(:right, :lte, value)
    end

    def trailing(value=nil)
      target_constraint(:trailing, :equal, value)
    end

    def min_trailing(value=nil)
      target_constraint(:trailing, :gte, value)
    end

    def max_trailing(value=nil)
      target_constraint(:trailing, :lte, value)
    end

    def y(value=nil)
      target_constraint(:top, :equal, value)
    end
    alias top y

    def min_y(value=nil)
      target_constraint(:top, :gte, value)
    end
    alias min_top min_y

    def max_y(value=nil)
      target_constraint(:top, :lte, value)
    end
    alias max_top max_y

    def center_y(value=nil)
      target_constraint(:center_y, :equal, value)
    end

    def min_center_y(value=nil)
      target_constraint(:center_y, :gte, value)
    end

    def max_center_y(value=nil)
      target_constraint(:center_y, :lte, value)
    end

    def bottom(value=nil)
      target_constraint(:bottom, :equal, value)
    end

    def min_bottom(value=nil)
      target_constraint(:bottom, :gte, value)
    end

    def max_bottom(value=nil)
      target_constraint(:bottom, :lte, value)
    end

    def baseline(value=nil)
      target_constraint(:baseline, :equal, value)
    end

    def min_baseline(value=nil)
      target_constraint(:baseline, :gte, value)
    end

    def max_baseline(value=nil)
      target_constraint(:baseline, :lte, value)
    end

    def width(value=nil)
      target_constraint(:width, :equal, value)
    end
    alias w width

    def min_width(value=nil)
      target_constraint(:width, :gte, value)
    end

    def max_width(value=nil)
      target_constraint(:width, :lte, value)
    end

    def height(value=nil)
      target_constraint(:height, :equal, value)
    end
    alias h height

    def min_height(value=nil)
      target_constraint(:height, :gte, value)
    end

    def max_height(value=nil)
      target_constraint(:height, :lte, value)
    end

    def size(value=nil)
      target_constraint(:size, :equal, value, SizeConstraint)
    end

    def min_size(value=nil)
      target_constraint(:size, :gte, value, SizeConstraint)
    end

    def max_size(value=nil)
      target_constraint(:size, :lte, value, SizeConstraint)
    end

    def center(value=nil)
      target_constraint([:center_x, :center_y], :equal, value, PointConstraint)
    end

    def min_center(value=nil)
      target_constraint([:center_x, :center_y], :gte, value, PointConstraint)
    end

    def max_center(value=nil)
      target_constraint([:center_x, :center_y], :lte, value, PointConstraint)
    end

    def top_left(value=nil)
      target_constraint([:left, :top], :equal, value, PointConstraint)
    end
    alias origin top_left

    def top_right(value=nil)
      target_constraint([:right, :top], :equal, value, PointConstraint)
    end

    def bottom_left(value=nil)
      target_constraint([:left, :bottom], :equal, value, PointConstraint)
    end

    def bottom_right(value=nil)
      target_constraint([:right, :bottom], :equal, value, PointConstraint)
    end

    def above(view)
      constraint = Constraint.new(target.view, :bottom, :equal)
      constraint.equals(view, :top)

      target.add_constraints([constraint])
      return constraint
    end

    def below(view)
      constraint = Constraint.new(target.view, :top, :equal)
      constraint.equals(view, :bottom)

      target.add_constraints([constraint])
      return constraint
    end

    def before(view)
      constraint = Constraint.new(target.view, :right, :equal)
      constraint.equals(view, :left)

      target.add_constraints([constraint])
      return constraint
    end
    alias left_of before

    def after(view)
      constraint = Constraint.new(target.view, :left, :equal)
      constraint.equals(view, :right)

      target.add_constraints([constraint])
      return constraint
    end
    alias right_of after

  private

    def target_constraint(attribute, relationship, value=nil, constraint_class=nil)
      constraint_class ||= Constraint
      constraint = constraint_class.new(target.view, attribute, relationship)
      constraint.equals(value) if value
      target.add_constraints([constraint])
      constraint
    end

  end
end
