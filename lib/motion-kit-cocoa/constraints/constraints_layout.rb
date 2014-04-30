# @requires MotionKit::BaseLayout
module MotionKit
  class ConstraintsLayout < BaseLayout
    targets ConstraintsTarget

    def x(value=nil)
      constraint = Constraint.new(target, :left, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias left x

    def min_x(value=nil)
      constraint = Constraint.new(target, :left, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias min_left min_x

    def max_x(value=nil)
      constraint = Constraint.new(target, :left, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias max_left max_x

    def center_x(value=nil)
      constraint = Constraint.new(target, :center_x, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_center_x(value=nil)
      constraint = Constraint.new(target, :center_x, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_center_x(value=nil)
      constraint = Constraint.new(target, :center_x, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def right(value=nil)
      constraint = Constraint.new(target, :right, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_right(value=nil)
      constraint = Constraint.new(target, :right, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_right(value=nil)
      constraint = Constraint.new(target, :right, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def y(value=nil)
      constraint = Constraint.new(target, :top, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias top y

    def min_y(value=nil)
      constraint = Constraint.new(target, :top, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias min_top min_y

    def max_y(value=nil)
      constraint = Constraint.new(target, :top, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias max_top max_y

    def center_y(value=nil)
      constraint = Constraint.new(target, :center_y, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_center_y(value=nil)
      constraint = Constraint.new(target, :center_y, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_center_y(value=nil)
      constraint = Constraint.new(target, :center_y, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def bottom(value=nil)
      constraint = Constraint.new(target, :bottom, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def min_bottom(value=nil)
      constraint = Constraint.new(target, :bottom, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_bottom(value=nil)
      constraint = Constraint.new(target, :bottom, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def width(value=nil)
      constraint = Constraint.new(target, :width, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias w width

    def min_width(value=nil)
      constraint = Constraint.new(target, :width, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_width(value=nil)
      constraint = Constraint.new(target, :width, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def height(value=nil)
      constraint = Constraint.new(target, :height, :equal)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end
    alias h height

    def min_height(value=nil)
      constraint = Constraint.new(target, :height, :gte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def max_height(value=nil)
      constraint = Constraint.new(target, :height, :lte)
      constraint.constant = value if value

      target.add_constraints([constraint])
      return constraint
    end

    def origin(value=nil)
    end

    def center(value=nil)
    end

    def size(value=nil)
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
