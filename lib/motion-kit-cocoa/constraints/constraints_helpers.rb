# @provides MotionKit::ConstraintsHelpers
# @requires MotionKit::BaseLayout
# @requires MotionKit::ConstraintsTarget
module MotionKit
  class ConstraintsHelpers < BaseLayout
    targets ConstraintsTarget

    # A more sensible name for the constraint that is created.
    def constraint_target
      target
    end

    def left(value=nil, rel=nil)
      target_constraint(:left, rel, value)
    end
    alias x left

    def min_left(value=nil)
      left(value, :gte)
    end
    alias min_x min_left

    def max_left(value=nil)
      left(value, :lte)
    end
    alias max_x max_left

    def leading(value=nil, rel=nil)
      target_constraint(:leading, rel, value)
    end

    def min_leading(value=nil)
      leading(value, :gte)
    end

    def max_leading(value=nil)
      leading(value, :lte)
    end

    def center_x(value=nil, rel=nil)
      target_constraint(:center_x, rel, value)
    end

    def min_center_x(value=nil)
      center_x(value, :gte)
    end

    def max_center_x(value=nil)
      center_x(value, :lte)
    end

    def right(value=nil, rel=nil)
      target_constraint(:right, rel, value)
    end

    def min_right(value=nil)
      right(value, :gte)
    end

    def max_right(value=nil)
      right(value, :lte)
    end

    def trailing(value=nil, rel=nil)
      target_constraint(:trailing, rel, value)
    end

    def min_trailing(value=nil)
      trailing(value, :gte)
    end

    def max_trailing(value=nil)
      trailing(value, :lte)
    end

    def top(value=nil, rel=nil)
      target_constraint(:top, rel, value)
    end
    alias y top

    def min_top(value=nil)
      top(value, :gte)
    end
    alias min_y min_top

    def max_top(value=nil)
      top(value, :lte)
    end
    alias max_y max_top

    def center_y(value=nil, rel=nil)
      target_constraint(:center_y, rel, value)
    end

    def min_center_y(value=nil)
      center_y(value, :gte)
    end

    def max_center_y(value=nil)
      center_y(value, :lte)
    end

    def bottom(value=nil, rel=nil)
      target_constraint(:bottom, rel, value)
    end

    def min_bottom(value=nil)
      bottom(value, :gte)
    end

    def max_bottom(value=nil)
      bottom(value, :lte)
    end

    def baseline(value=nil, rel=nil)
      target_constraint(:baseline, rel, value)
    end

    def min_baseline(value=nil)
      baseline(value, :gte)
    end

    def max_baseline(value=nil)
      baseline(value, :lte)
    end

    def width(value=nil, rel=nil)
      target_constraint(:width, rel, value)
    end
    alias w width

    def min_width(value=nil)
      width(value, :gte)
    end

    def max_width(value=nil)
      width(value, :lte)
    end

    def height(value=nil, rel=nil)
      target_constraint(:height, :equal, value)
    end
    alias h height

    def min_height(value=nil)
      target_constraint(:height, :gte, value)
    end

    def max_height(value=nil)
      target_constraint(:height, :lte, value)
    end

    def size(value=nil, rel=nil)
      target_constraint(:size, rel, value, SizeConstraint)
    end

    def min_size(value=nil)
      size(value, :gte)
    end

    def max_size(value=nil)
      size(value, :lte)
    end

    def center(value=nil, rel=nil)
      target_constraint([:center_x, :center_y], rel, value, PointConstraint)
    end

    def min_center(value=nil)
      center(value, :gte)
    end

    def max_center(value=nil)
      center(value, :lte)
    end

    def top_left(value=nil, rel=nil)
      target_constraint([:left, :top], rel, value, PointConstraint)
    end
    alias origin top_left

    def min_top_left(value=nil)
      top_left(value, :gte)
    end
    alias min_origin min_top_left

    def max_top_left(value=nil)
      top_left(value, :lte)
    end
    alias max_origin max_top_left

    def top_right(value=nil, rel=nil)
      target_constraint([:right, :top], rel, value, PointConstraint)
    end

    def min_top_right(value=nil)
      top_right(value, :gte)
    end

    def max_top_right(value=nil)
      top_right(value, :lte)
    end

    def bottom_left(value=nil, rel=nil)
      target_constraint([:left, :bottom], rel, value, PointConstraint)
    end

    def min_bottom_left(value=nil)
      bottom_left(value, :gte)
    end

    def max_bottom_left(value=nil)
      bottom_left(value, :lte)
    end

    def bottom_right(value=nil, rel=nil)
      target_constraint([:right, :bottom], rel, value, PointConstraint)
    end

    def min_bottom_right(value=nil)
      bottom_right(value, :gte)
    end

    def max_bottom_right(value=nil)
      bottom_right(value, :lte)
    end

    def above(view)
      unless view
        raise ArgumentError.new("`#{view.inspect}` is not a valid target for making a `above` constraint.")
      end
      constraint = Constraint.new(constraint_target.view, :bottom, :equal)
      constraint.equals(view, :top)

      constraint_target.add_constraints([constraint])
      return constraint
    end

    def below(view)
      unless view
        raise ArgumentError.new("`#{view.inspect}` is not a valid target for making a `below` constraint.")
      end
      constraint = Constraint.new(constraint_target.view, :top, :equal)
      constraint.equals(view, :bottom)

      constraint_target.add_constraints([constraint])
      return constraint
    end

    def before(view)
      unless view
        raise ArgumentError.new("`#{view.inspect}` is not a valid target for making a `before` constraint.")
      end
      constraint = Constraint.new(constraint_target.view, :right, :equal)
      constraint.equals(view, :left)

      constraint_target.add_constraints([constraint])
      return constraint
    end
    alias left_of before

    def after(view)
      unless view
        raise ArgumentError.new("`#{view.inspect}` is not a valid target for making a `after` constraint.")
      end
      constraint = Constraint.new(constraint_target.view, :left, :equal)
      constraint.equals(view, :right)

      constraint_target.add_constraints([constraint])
      return constraint
    end
    alias right_of after

  private

    def target_constraint(attribute, relationship, value=nil, constraint_class=nil)
      constraint_class ||= Constraint
      constraint = constraint_class.new(constraint_target.view, attribute, relationship)
      if value == :scale
        size = ViewCalculator.intrinsic_size(constraint_target.view)
        if attribute == :width
          constraint.equals(:self, :height).times(size.width / size.height)
        elsif attribute == :height
          constraint.equals(:self, :width).times(size.height / size.width)
        else
          raise "Cannot apply :scale relationship to #{attribute}"
        end
      elsif value
        constraint.equals(value)
      end
      constraint_target.add_constraints([constraint])
      constraint
    end

  end
end
