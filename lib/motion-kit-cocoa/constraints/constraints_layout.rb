# @requires MotionKit::BaseLayout
module MotionKit
  class ConstraintsLayout < BaseLayout
    targets ConstraintsTarget

    def x(value=nil)
      constraint = Constraint.new(target.view, :left, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias left x

    def min_x(value=nil)
      constraint = Constraint.new(target.view, :left, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias min_left min_x

    def max_x(value=nil)
      constraint = Constraint.new(target.view, :left, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias max_left max_x

    def leading(value=nil)
      constraint = Constraint.new(target.view, :leading, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_leading(value=nil)
      constraint = Constraint.new(target.view, :leading, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_leading(value=nil)
      constraint = Constraint.new(target.view, :leading, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def center_x(value=nil)
      constraint = Constraint.new(target.view, :center_x, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_center_x(value=nil)
      constraint = Constraint.new(target.view, :center_x, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_center_x(value=nil)
      constraint = Constraint.new(target.view, :center_x, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def right(value=nil)
      constraint = Constraint.new(target.view, :right, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_right(value=nil)
      constraint = Constraint.new(target.view, :right, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_right(value=nil)
      constraint = Constraint.new(target.view, :right, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def trailing(value=nil)
      constraint = Constraint.new(target.view, :trailing, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_trailing(value=nil)
      constraint = Constraint.new(target.view, :trailing, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_trailing(value=nil)
      constraint = Constraint.new(target.view, :trailing, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def y(value=nil)
      constraint = Constraint.new(target.view, :top, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias top y

    def min_y(value=nil)
      constraint = Constraint.new(target.view, :top, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias min_top min_y

    def max_y(value=nil)
      constraint = Constraint.new(target.view, :top, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias max_top max_y

    def center_y(value=nil)
      constraint = Constraint.new(target.view, :center_y, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_center_y(value=nil)
      constraint = Constraint.new(target.view, :center_y, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_center_y(value=nil)
      constraint = Constraint.new(target.view, :center_y, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def bottom(value=nil)
      constraint = Constraint.new(target.view, :bottom, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_bottom(value=nil)
      constraint = Constraint.new(target.view, :bottom, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_bottom(value=nil)
      constraint = Constraint.new(target.view, :bottom, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def baseline(value=nil)
      constraint = Constraint.new(target.view, :baseline, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_baseline(value=nil)
      constraint = Constraint.new(target.view, :baseline, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_baseline(value=nil)
      constraint = Constraint.new(target.view, :baseline, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def width(value=nil)
      constraint = Constraint.new(target.view, :width, :equal)
      if value && (value.is_a?(String) || value.is_a?(Symbol))
        constraint.relative_to = value
      else
        constraint.constant = value if value
      end

      target.add_constraints([constraint])
      return constraint
    end
    alias w width

    def min_width(value=nil)
      constraint = Constraint.new(target.view, :width, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_width(value=nil)
      constraint = Constraint.new(target.view, :width, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def height(value=nil)
      constraint = Constraint.new(target.view, :height, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias h height

    def min_height(value=nil)
      constraint = Constraint.new(target.view, :height, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_height(value=nil)
      constraint = Constraint.new(target.view, :height, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def size(value=nil)
      constraint = SizeConstraint.new(target.view, :size, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_size(value=nil)
      constraint = SizeConstraint.new(target.view, :size, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_size(value=nil)
      constraint = SizeConstraint.new(target.view, :size, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def center(value=nil)
      constraint = PointConstraint.new(target.view, [:center_x, :center_y], :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_center(value=nil)
      constraint = PointConstraint.new(target.view, [:center_x, :center_y], :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_center(value=nil)
      constraint = PointConstraint.new(target.view, [:center_x, :center_y], :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def frame(value=nil)
    end

    def full(value=nil)
    end

    def full_width(value=nil)
    end

    def full_height(value=nil)
    end

    def centered(value=nil)
    end

    def from_top_left(value=nil)
    end

    def from_top(value=nil)
    end

    def from_top_right(value=nil)
    end

    def from_left(value=nil)
    end

    def from_center(value=nil)
    end

    def from_right(value=nil)
    end

    def from_bottom_left(value=nil)
    end

    def from_bottom(value=nil)
    end

    def from_bottom_right(value=nil)
    end

    def above(value=nil)
    end

    def below(value=nil)
    end

    def before(value=nil)
    end

    def after(value=nil)
    end

    def relative_to(value=nil)
    end

  end
end
