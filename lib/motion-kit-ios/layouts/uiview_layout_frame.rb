motion_require 'uiview_layout'

module MotionKit
  class UIViewLayout

    def x(value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, value)
      target.frame = f
    end
    alias left x

    def right(value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, value) - f.size.width
      target.frame = f
    end

    def center_x(value)
      c = target.center
      c.x = MotionKit.calculate(target, :width, value)
      target.center = c
    end
    alias middle_x center_x

    def y(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value)
      target.frame = f
    end
    alias top y

    def bottom(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value) - f.size.height
      target.frame = f
    end

    def center_y(value)
      c = target.center
      c.y = MotionKit.calculate(target, :height, value)
      target.center = c
    end
    alias middle_y center_y

    def width(value)
      f = target.frame
      f.size.width = MotionKit.calculate(target, :width, value)
      target.frame = f
    end

    def height(value)
      f = target.frame
      f.size.height = MotionKit.calculate(target, :height, value)
      target.frame = f
    end

    def origin(value)
      f = target.frame
      origin_x = MotionKit.calculate(target, :width, value[0])
      origin_y = MotionKit.calculate(target, :height, value[1])
      f.origin = [origin_x, origin_y]
      target.frame = f
    end

    def center(value)
      center_x = MotionKit.calculate(target, :width, value[0])
      center_y = MotionKit.calculate(target, :height, value[1])
      target.center = [center_x, center_y]
    end

    def size(value)
      if value == :full
        if target.superview
          value = target.superview.bounds.size
        else
          value = target.frame.size
        end
      else
        value = [MotionKit.calculate(target, :width, value[0]), MotionKit.calculate(target, :height, value[1])]
      end
      f = target.frame
      f.size = value
      target.frame = f
    end

    def frame(value)
      if Symbol === value && value == :full
        if target.superview
          value = target.superview.bounds
        else
          value = target.frame
        end
      elsif Array === value && value.length == 4
        value = [
            [MotionKit.calculate(target, :width, value[0]), MotionKit.calculate(target, :height, value[1])],
            [MotionKit.calculate(target, :width, value[2]), MotionKit.calculate(target, :height, value[3])]
          ]
      else
        value = [
            [MotionKit.calculate(target, :width, value[0][0]), MotionKit.calculate(target, :height, value[0][1])],
            [MotionKit.calculate(target, :width, value[1][0]), MotionKit.calculate(target, :height, value[1][1])]
          ]
      end
      target.frame = value
    end

  end
end
