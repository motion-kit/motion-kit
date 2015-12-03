# @requires MotionKit::UIViewHelpers
module MotionKit
  class UIViewHelpers

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
    alias w width

    def height(value)
      f = target.frame
      f.size.height = MotionKit.calculate(target, :height, value)
      target.frame = f
      return CGRectGetHeight(f)
    end
    alias h height

    def origin(value)
      f = target.frame
      f.origin = MotionKit.calculate(target, :origin, value)
      target.frame = f
      return target.frame.origin
    end

    def center(value)
      target.center = MotionKit.calculate(target, :center, value)
      return target.center
    end
    alias middle center

    def size(value)
      f = target.frame
      f.size = MotionKit.calculate(target, :size, value)
      target.frame = f
      return target.frame.size
    end

    def frame(value)
      target.frame = MotionKit.calculate(target, :frame, value)
      return target.frame
    end

    def _calculate_frame(f, from: from_view, relative_to: point)
      if from_view.is_a?(Symbol)
        from_view = self.get_view(from_view)
      end

      from_view_size = from_view.frame.size
      o = from_view.convertPoint([0, 0], toView: target.superview)

      calculate_view = UIView.alloc.initWithFrame([[0, 0], target.frame.size])

      if f.is_a?(Hash)
        f = f.merge(relative: true)
      end
      f = MotionKit.calculate(calculate_view, :frame, f, target.superview)
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
      when :min, :reset
        # pass
      when :mid
        f.origin.y += (from_view_size.height - f.size.height) / 2.0
      when :max
        f.origin.y += from_view_size.height - f.size.height
      when :above
        f.origin.y -= f.size.height
      when :below
        f.origin.y += from_view_size.height
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
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :min, y: :min })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_top(width: 80, height: 22)
    #   frame from_top(another_view, width: 80, height: 22)
    def from_top(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :mid, y: :min })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_top_right(width: 80, height: 22)
    #   frame from_top_right(another_view, width: 80, height: 22)
    def from_top_right(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :max, y: :min })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_left(width: 80, height: 22)
    #   frame from_left(another_view, width: 80, height: 22)
    def from_left(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :min, y: :mid })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_center(width: 80, height: 22)
    #   frame from_center(another_view, width: 80, height: 22)
    def from_center(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :mid, y: :mid })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_right(width: 80, height: 22)
    #   frame from_right(another_view, width: 80, height: 22)
    def from_right(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :max, y: :mid })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_bottom_left(width: 80, height: 22)
    #   frame from_bottom_left(another_view, width: 80, height: 22)
    def from_bottom_left(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :min, y: :max })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_bottom(width: 80, height: 22)
    #   frame from_bottom(another_view, width: 80, height: 22)
    def from_bottom(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :mid, y: :max })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame from_bottom_right(width: 80, height: 22)
    #   frame from_bottom_right(another_view, width: 80, height: 22)
    def from_bottom_right(from_view=nil, f=nil)
      if from_view.is_a?(Hash)
        f = from_view
        from_view = nil
      end
      f ||= {}
      from_view ||= target.superview
      _calculate_frame(f, from: from_view, relative_to: { x: :max, y: :max })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame above(view, [[0, 0], [100, 20]])
    #   frame above(:view, x: 0, y: 0, width: 100, height: 20)
    #   frame above(:view, down: 0, right: 0, width: 100, height: 20)
    def above(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :reset, y: :above })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame below(view, [[0, 0], [100, 20]])
    #   frame below(:view, x: 0, y: 0, width: 100, height: 20)
    #   frame below(:view, down: 0, right: 0, width: 100, height: 20)
    def below(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :reset, y: :below })
    end

    # The first arg can be a view or a frame
    # @example
    #   frame before(view, [[0, 0], [100, 20]])
    #   frame before(:view, x: 0, y: 0, width: 100, height: 20)
    #   frame before(:view, down: 0, right: 0, width: 100, height: 20)
    def before(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :before, y: :reset })
    end
    alias left_of before

    # The first arg can be a view or a frame
    # @example
    #   frame after(view, [[0, 0], [100, 20]])
    #   frame after(:view, x: 0, y: 0, width: 100, height: 20)
    #   frame after(:view, down: 0, right: 0, width: 100, height: 20)
    def after(from_view, f={})
      _calculate_frame(f, from: from_view, relative_to: { x: :after, y: :reset })
    end
    alias right_of after

    # The first arg must be a view
    # @example
    #   frame relative_to(view, [[0, 0], [100, 20]])
    #   frame relative_to(:view, x: 0, y: 0, width: 100, height: 20)
    #   frame relative_to(:view, down: 0, right: 0, width: 100, height: 20)
    def relative_to(from_view, f)
      _calculate_frame(f, from: from_view, relative_to: { x: :reset, y: :reset })
    end

  end
end
