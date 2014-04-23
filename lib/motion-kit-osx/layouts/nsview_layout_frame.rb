motion_require 'nsview_layout'

module MotionKit
  class NSViewLayout

    def _fix_frame_value(value)
      if value.is_a?(Hash) && value[:relative]
        return value.merge(flipped: flipped?)
      end
      return value
    end

    def flipped?
      target.superview && !target.superview.flipped?
    end

    def x(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, value)
      target.frame = f
      return CGRectGetMinX(f)
    end
    alias left x

    def right(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, value) - f.size.width
      target.frame = f
      return CGRectGetMaxX(f)
    end

    def center_x(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin.x = MotionKit.calculate(target, :width, value)
      f.origin.x -= f.size.width / 2
      target.frame = f
      return CGRectGetMidX(target.frame)
    end
    alias middle_x center_x

    def y(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value)
      target.frame = f
      return CGRectGetMinY(f)
    end

    def bottom(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value)
      unless flipped?
        f.origin.y -= f.size.height
      end
      target.frame = f

      if flipped?
        return CGRectGetMinY(target.frame)
      else
        return CGRectGetMaxY(target.frame)
      end
    end

    def top(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value)
      if flipped?
        f.origin.y -= f.size.height
      end
      target.frame = f

      if flipped?
        return CGRectGetMaxY(f)
      else
        return CGRectGetMinY(f)
      end
    end

    def center_y(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin.y = MotionKit.calculate(target, :height, value)
      f.origin.y -= f.size.height / 2
      target.frame = f
      return CGRectGetMidY(target.frame)
    end
    alias middle_y center_y

    def width(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.size.width = MotionKit.calculate(target, :width, value)
      target.frame = f
      return CGRectGetWidth(f)
    end

    def height(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.size.height = MotionKit.calculate(target, :height, value)
      target.frame = f
      return CGRectGetHeight(f)
    end

    def origin(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.origin = MotionKit.calculate(target, :origin, value)
      target.frame = f
      return target.frame.origin
    end

    def center(value)
      value = _fix_frame_value(value)
      f = target.frame
      center = MotionKit.calculate(target, :center, value)
      origin = CGPoint.new(center.x, center.y)
      origin.x -= f.size.width / 2
      origin.y -= f.size.height / 2
      f.origin = origin
      target.frame = f
      return center
    end
    alias middle center

    def size(value)
      value = _fix_frame_value(value)
      f = target.frame
      f.size = MotionKit.calculate(target, :size, value)
      target.frame = f
      return target.frame.size
    end

    def frame(value)
      value = _fix_frame_value(value)
      target.frame = MotionKit.calculate(target, :frame, value)
      return target.frame
    end

    def _calculate_frame(f, from: from_view, relative_to: point)
      if from_view.is_a?(Symbol)
        from_view = self.get(from_view)
      end

      from_view_size = from_view.frame.size
      o = from_view.convertPoint([0, 0], toView: target.superview)

      calculate_view = target

      if point[:x] == :reset || point[:y] == :reset
        calculate_view = NSView.alloc.initWithFrame([[0, 0], target.frame.size])
      end

      if f.is_a?(Hash)
        f = f.merge(relative: true, flipped: flipped?)
      end
      f = MotionKit.calculate(calculate_view, :frame, f, from_view)
      f.origin.x += o.x
      f.origin.y += o.y

      case point[:x]
      when :min, :reset
        # pass
      when :mid
        f.origin.x += (from_view_size.width - f.size.width) / 2.0
      when :max
        f.origin.x += from_view_size.width - f.size.width
      when :before
        f.origin.x -= f.size.width
      when :after
        f.origin.x += from_view_size.width
      else
        f.origin.x += point[:x]
      end

      case point[:y]
      when :reset
        # pass
      when :min
        unless flipped?
          f.origin.y += from_view_size.height - f.size.height
        end
      when :mid
        f.origin.y += (from_view_size.height - f.size.height) / 2.0
      when :max
        if flipped?
          f.origin.y += from_view_size.height - f.size.height
        end
      when :above
        if flipped?
          f.origin.y += from_view_size.height
        else
          f.origin.y -= from_view_size.height + f.size.height
        end
      when :below
        if flipped?
          f.origin.y -= f.size.height
        else
          # pass
        end
      else
        f.origin.y += point[:y]
      end

      return f
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_top_left(width: 80, height: 22)
    #   frame from_top_left(another_view, width: 80, height: 22)
    def from_top_left(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :min, y: :max })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_top(width: 80, height: 22)
    #   frame from_top(another_view, width: 80, height: 22)
    def from_top(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :mid, y: :max })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_top_right(width: 80, height: 22)
    #   frame from_top_right(another_view, width: 80, height: 22)
    def from_top_right(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :max, y: :max })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_left(width: 80, height: 22)
    #   frame from_left(another_view, width: 80, height: 22)
    def from_left(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :min, y: :mid })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_center(width: 80, height: 22)
    #   frame from_center(another_view, width: 80, height: 22)
    def from_center(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :mid, y: :mid })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_right(width: 80, height: 22)
    #   frame from_right(another_view, width: 80, height: 22)
    def from_right(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :max, y: :mid })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_bottom_left(width: 80, height: 22)
    #   frame from_bottom_left(another_view, width: 80, height: 22)
    def from_bottom_left(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :min, y: :min })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_bottom(width: 80, height: 22)
    #   frame from_bottom(another_view, width: 80, height: 22)
    def from_bottom(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :mid, y: :min })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_bottom_right(width: 80, height: 22)
    #   frame from_bottom_right(another_view, width: 80, height: 22)
    def from_bottom_right(from_view=nil, f=nil)
      unless from_view.is_a?(NSView)
        f = from_view || {}
        from_view = target.superview
      end
      _calculate_frame(f, from: from_view, relative_to: { x: :max, y: :min })
    end

    # The first arg can be a view or a frame
    # @example
    def above(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :reset, y: :above })
    end

    # The first arg can be a view or a frame
    # @example
    def below(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :reset, y: :below })
    end

    # The first arg can be a view or a frame
    # @example
    def before(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :before, y: :reset })
    end
    alias left_of before

    # The first arg can be a view or a frame
    # @example
    def after(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :after, y: :reset })
    end
    alias right_of after

    # The first arg must be a view
    # @example
    def relative_to(from_view, f)
      _calculate_frame(f, from: from_view, relative_to: { x: :reset, y: :reset })
    end

  end
end
