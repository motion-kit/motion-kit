motion_require 'uiview_layout'

module MotionKit
  class UIViewLayout

    def x(target, value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, x)
      target.frame = f
    end
    alias left x

    def right
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, r) - f.size.width
      target.frame = f
    end

    def center_x(target, value)
      c = target.center
      c.x = MotionKit.calculate(target, :width, x)
      target.center = c
    end
    alias middle_x center_x

    def y(target, value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, y)
      target.frame = f
    end
    alias top y

    def bottom(target, value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, b) - f.size.height
      target.frame = f
    end

    def center_y(target, value)
      c = target.center
      c.y = MotionKit.calculate(target, :height, y)
      target.center = c
    end
    alias middle_y center_y

    def width(target, value)
      f = target.frame
      f.size.width = MotionKit.calculate(target, :width, w)
      target.frame = f
    end

    def height(target, value)
      f = target.frame
      f.size.height = MotionKit.calculate(target, :height, h)
      target.frame = f
    end

    def origin(target, value)
      f = target.frame
      origin_x = MotionKit.calculate(target, :width, origin[0])
      origin_y = MotionKit.calculate(target, :height, origin[1])
      f.origin = [origin_x, origin_y]
      target.frame = f
    end

    def center(target, value)
      center_x = MotionKit.calculate(target, :width, center[0])
      center_y = MotionKit.calculate(target, :height, center[1])
      target.center = [center_x, center_y]
    end

    def size(target, value)
      if size == :full
        if target.superview
          size = target.superview.bounds.size
        else
          size = target.frame.size
        end
      else
        size = [MotionKit.calculate(target, :width, size[0]), MotionKit.calculate(target, :height, size[1])]
      end
      f = target.frame
      f.size = size
      target.frame = f
    end

    def frame(target, frame)
      if Symbol === frame && frame == :full
        if target.superview
          frame = target.superview.bounds
        else
          frame = target.frame
        end
      elsif Array === frame && frame.length == 4
        frame = [
            [MotionKit.calculate(target, :width, frame[0]), MotionKit.calculate(target, :height, frame[1])],
            [MotionKit.calculate(target, :width, frame[2]), MotionKit.calculate(target, :height, frame[3])]
          ]
      else
        frame = [
            [MotionKit.calculate(target, :width, frame[0][0]), MotionKit.calculate(target, :height, frame[0][1])],
            [MotionKit.calculate(target, :width, frame[1][0]), MotionKit.calculate(target, :height, frame[1][1])]
          ]
      end
      target.frame = frame
    end

  end
end
