# @provides MotionKit::ConstraintsLayout
# @requires MotionKit::BaseLayout
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
      constraint = Constraint.new(target.view, :left, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias left x

    def min_x(value=nil)
      constraint = Constraint.new(target.view, :left, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias min_left min_x

    def max_x(value=nil)
      constraint = Constraint.new(target.view, :left, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias max_left max_x

    def leading(value=nil)
      constraint = Constraint.new(target.view, :leading, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_leading(value=nil)
      constraint = Constraint.new(target.view, :leading, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_leading(value=nil)
      constraint = Constraint.new(target.view, :leading, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def center_x(value=nil)
      constraint = Constraint.new(target.view, :center_x, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_center_x(value=nil)
      constraint = Constraint.new(target.view, :center_x, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_center_x(value=nil)
      constraint = Constraint.new(target.view, :center_x, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def right(value=nil)
      constraint = Constraint.new(target.view, :right, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_right(value=nil)
      constraint = Constraint.new(target.view, :right, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_right(value=nil)
      constraint = Constraint.new(target.view, :right, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def trailing(value=nil)
      constraint = Constraint.new(target.view, :trailing, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_trailing(value=nil)
      constraint = Constraint.new(target.view, :trailing, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_trailing(value=nil)
      constraint = Constraint.new(target.view, :trailing, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def y(value=nil)
      constraint = Constraint.new(target.view, :top, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias top y

    def min_y(value=nil)
      constraint = Constraint.new(target.view, :top, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias min_top min_y

    def max_y(value=nil)
      constraint = Constraint.new(target.view, :top, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias max_top max_y

    def center_y(value=nil)
      constraint = Constraint.new(target.view, :center_y, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_center_y(value=nil)
      constraint = Constraint.new(target.view, :center_y, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_center_y(value=nil)
      constraint = Constraint.new(target.view, :center_y, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def bottom(value=nil)
      constraint = Constraint.new(target.view, :bottom, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_bottom(value=nil)
      constraint = Constraint.new(target.view, :bottom, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_bottom(value=nil)
      constraint = Constraint.new(target.view, :bottom, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def baseline(value=nil)
      constraint = Constraint.new(target.view, :baseline, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_baseline(value=nil)
      constraint = Constraint.new(target.view, :baseline, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_baseline(value=nil)
      constraint = Constraint.new(target.view, :baseline, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def width(value=nil)
      constraint = Constraint.new(target.view, :width, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias w width

    def min_width(value=nil)
      constraint = Constraint.new(target.view, :width, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_width(value=nil)
      constraint = Constraint.new(target.view, :width, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def height(value=nil)
      constraint = Constraint.new(target.view, :height, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias h height

    def min_height(value=nil)
      constraint = Constraint.new(target.view, :height, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_height(value=nil)
      constraint = Constraint.new(target.view, :height, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def size(value=nil)
      constraint = SizeConstraint.new(target.view, :size, :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_size(value=nil)
      constraint = SizeConstraint.new(target.view, :size, :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_size(value=nil)
      constraint = SizeConstraint.new(target.view, :size, :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def center(value=nil)
      constraint = PointConstraint.new(target.view, [:center_x, :center_y], :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def min_center(value=nil)
      constraint = PointConstraint.new(target.view, [:center_x, :center_y], :gte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def max_center(value=nil)
      constraint = PointConstraint.new(target.view, [:center_x, :center_y], :lte)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def top_left(value=nil)
      constraint = PointConstraint.new(target.view, [:left, :top], :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias origin top_left

    def top_right(value=nil)
      constraint = PointConstraint.new(target.view, [:right, :top], :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def bottom_left(value=nil)
      constraint = PointConstraint.new(target.view, [:left, :bottom], :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
    end

    def bottom_right(value=nil)
      constraint = PointConstraint.new(target.view, [:right, :bottom], :equal)

      if value
        constraint.equals(value)
      end

      target.add_constraints([constraint])
      return constraint
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

  end
end
