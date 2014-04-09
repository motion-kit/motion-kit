motion_require 'uiview_layout'

module MotionKit
  class UIViewLayout

    def x(value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, value)
      target.frame = f
      return CGRectGetMinX(f)
    end
    alias left x

    def right(value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, value) - f.size.width
      target.frame = f
      return CGRectGetMaxX(f)
    end

    def center_x(value)
      c = target.center
      c.x = MotionKit.calculate(target, :width, value)
      target.center = c
      return CGRectGetMidX(target.frame)
    end
    alias middle_x center_x

    def y(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value)
      target.frame = f
      return CGRectGetMinY(f)
    end
    alias top y

    def bottom(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value) - f.size.height
      target.frame = f
      return CGRectGetMaxY(f)
    end

    def center_y(value)
      c = target.center
      c.y = MotionKit.calculate(target, :height, value)
      target.center = c
      return CGRectGetMidY(target.frame)
    end
    alias middle_y center_y

    def width(value)
      f = target.frame
      f.size.width = MotionKit.calculate(target, :width, value)
      target.frame = f
      return CGRectGetWidth(f)
    end

    def height(value)
      f = target.frame
      f.size.height = MotionKit.calculate(target, :height, value)
      target.frame = f
      return CGRectGetHeight(f)
    end

    def origin(value)
      f = target.frame
      if value.is_a?(Array) || value.is_a?(Hash)
        if value.is_a?(Hash)
          x = value.fetch(:x, value.fetch(:left, target.frame.origin.x))
          y = value.fetch(:y, value.fetch(:top, target.frame.origin.y))
        else
          x = value[0]
          y = value[1]
        end

        self.x x
        self.y y
        return target.frame.origin
      else
        f.origin = value
      end

      target.frame = f
      return target.frame.origin
    end

    def center(value)
      self.center_x value[0]
      self.center_y value[1]
      return target.center
    end

    def size(value)
      f = target.frame

      if value == :full
        if target.superview
          f.size = target.superview.frame.size
        else
          f.size = target.frame.size
        end
      elsif value == :auto
        target.sizeToFit
        return target.frame.size
      elsif value.is_a?(Array) || value.is_a?(Hash)
        if value.is_a?(Hash)
          w = value.fetch(:width, value.fetch(:w, target.frame.size.width))
          h = value.fetch(:height, value.fetch(:h, target.frame.size.height))
        else
          w = value[0]
          h = value[1]
        end

        if w == :scale && h == :scale
          raise "Either width or height can be :scale, but not both"
        elsif w == :scale
          size = target.sizeThatFits([0, 0])
          h = MotionKit.calculate(target, :height, h)
          w = h * size.width / size.height
        elsif h == :scale
          size = target.sizeThatFits([0, 0])
          w = MotionKit.calculate(target, :height, w)
          h = w * size.height / size.width
        else
          w = MotionKit.calculate(target, :width, w)
          h = MotionKit.calculate(target, :height, h)
        end

        f.size = [w, h]
      end

      target.frame = f
      return target.frame.size
    end

    def frame(value)
      if value.is_a?(Symbol)
        case value
        when :full
          if target.superview
            value = CGRect.new([0, 0], target.superview.frame.size)
          else
            value = CGRect.new([0, 0], [0, 0])
          end
        else
          raise "Unrecognized value #{value.inspect} in UIViewLayout#frame"
        end

        target.frame = value
      elsif value.is_a?(Array) && value.length == 2
        self.origin(value[0])
        self.size(value[1])
      elsif value.is_a?(Hash) && (value.key?(:origin) || value.key?(:size))
        self.origin(value[:origin]) if value.key?(:origin)
        self.size(value[:size]) if value.key?(:size)
      elsif value.is_a?(Array) || value.is_a?(Hash)
        if value.is_a?(Hash)
          x = value.fetch(:x, value.fetch(:left, target.frame.origin.x))
          y = value.fetch(:y, value.fetch(:top, target.frame.origin.y))
          w = value.fetch(:width, value.fetch(:w, target.frame.size.width))
          h = value.fetch(:height, value.fetch(:h, target.frame.size.height))
        elsif value.length == 4
          x = value[0]
          y = value[1]
          w = value[2]
          h = value[3]
        end

        self.origin([x, y])
        self.size([w, h])
      end

      return target.frame
    end

  end
end
