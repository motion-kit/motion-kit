# @requires MotionKit::NSWindowHelpers
module MotionKit
  class NSWindowHelpers

    def _fix_frame_value(value)
      if value.is_a?(Hash) && value[:relative]
        return value.merge(flipped: true)
      end
      return value
    end

    def frame(value, autosave_name=nil)
      value = _fix_frame_value(value)
      screen = target.screen || NSScreen.mainScreen
      value = MotionKit.calculate(target, :frame, value, screen)
      target.setFrame(value, display: true)
      if autosave_name
        target.setFrameAutosaveName(autosave_name)
      end
      return target.frame
    end

    def x(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin.x = MotionKit.calculate(target, :width, value, screen)
      target.setFrame(f, display: true)
      return CGRectGetMinX(f)
    end
    alias left x

    def right(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin.x = MotionKit.calculate(target, :width, value, screen) - f.size.width
      target.setFrame(f, display: true)
      return CGRectGetMaxX(f)
    end

    def center_x(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin.x = MotionKit.calculate(target, :width, value, screen)
      f.origin.x -= f.size.width / 2
      target.setFrame(f, display: true)
      return CGRectGetMidX(target.frame)
    end
    alias middle_x center_x

    def y(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin.y = MotionKit.calculate(target, :height, value, screen)
      target.setFrame(f, display: true)
      return CGRectGetMinY(f)
    end

    def bottom(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin.y = MotionKit.calculate(target, :height, value, screen)
      target.setFrame(f, display: true)

      return CGRectGetMinY(target.frame)
    end

    def top(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin.y = MotionKit.calculate(target, :height, value, screen)
      f.origin.y -= f.size.height
      target.setFrame(f, display: true)

      return CGRectGetMaxY(f)
    end

    def center_y(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin.y = MotionKit.calculate(target, :height, value, screen)
      f.origin.y -= f.size.height / 2
      target.setFrame(f, display: true)
      return CGRectGetMidY(target.frame)
    end
    alias middle_y center_y

    def width(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.size.width = MotionKit.calculate(target, :width, value, screen)
      target.setFrame(f, display: true)
      return CGRectGetWidth(f)
    end
    alias w width

    def height(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.size.height = MotionKit.calculate(target, :height, value, screen)
      target.setFrame(f, display: true)
      return CGRectGetHeight(f)
    end
    alias h height

    def origin(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.origin = MotionKit.calculate(target, :origin, value, screen)
      target.setFrame(f, display: true)
      return target.frame.origin
    end

    def center(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      center = MotionKit.calculate(target, :center, value, screen)
      origin = CGPoint.new(center.x, center.y)
      origin.x -= f.size.width / 2
      origin.y -= f.size.height / 2
      f.origin = origin
      target.setFrame(f, display: true)
      return center
    end
    alias middle center

    def size(value)
      value = _fix_frame_value(value)
      f = target.frame
      screen = target.screen || NSScreen.mainScreen
      f.size = MotionKit.calculate(target, :size, value, screen)
      target.setFrame(f, display: true)
      return target.frame.size
    end

    def _calculate_frame(f, from: from_window, relative_to: point)
      if from_window.is_a?(Symbol)
        from_window = self.get_view(from_window)
      end

      from_window_size = from_window.frame.size

      calculate_window = target

      if point[:x] == :reset || point[:y] == :reset
        calculate_window = NSWindow.alloc.init
        calculate_window.setFrame([[0, 0], target.frame.size], display: false)
      end

      if f.is_a?(Hash)
        f = f.merge(relative: true, flipped: true)
      end
      f = MotionKit.calculate(calculate_window, :frame, f, from_window)
      if from_window.is_a?(NSWindow)
        f.origin.x += from_window.frame.origin.x
        f.origin.y += from_window.frame.origin.y
      end

      case point[:x]
      when :min, :reset
        # pass
      when :mid
        f.origin.x += (from_window_size.width - f.size.width) / 2.0
      when :max
        f.origin.x += from_window_size.width - f.size.width
      when :before
        f.origin.x -= f.size.width
      when :after
        f.origin.x += from_window_size.width
      else
        f.origin.x += point[:x]
      end

      case point[:y]
      when :reset, :min
        # pass
      when :mid
        f.origin.y += (from_window_size.height - f.size.height) / 2.0
      when :max
        f.origin.y += from_window_size.height - f.size.height
      when :above
        f.origin.y += from_window_size.height
      when :below
        f.origin.y -= f.size.height
      else
        f.origin.y += point[:y]
      end

      return f
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_top_left(width: 80, height: 22)
    #   frame from_top_left(another_view, width: 80, height: 22)
    def from_top_left(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :min, y: :max })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_top(width: 80, height: 22)
    #   frame from_top(another_view, width: 80, height: 22)
    def from_top(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :mid, y: :max })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_top_right(width: 80, height: 22)
    #   frame from_top_right(another_view, width: 80, height: 22)
    def from_top_right(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :max, y: :max })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_left(width: 80, height: 22)
    #   frame from_left(another_view, width: 80, height: 22)
    def from_left(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :min, y: :mid })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_center(width: 80, height: 22)
    #   frame from_center(another_view, width: 80, height: 22)
    def from_center(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :mid, y: :mid })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_right(width: 80, height: 22)
    #   frame from_right(another_view, width: 80, height: 22)
    def from_right(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :max, y: :mid })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_bottom_left(width: 80, height: 22)
    #   frame from_bottom_left(another_view, width: 80, height: 22)
    def from_bottom_left(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :min, y: :min })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_bottom(width: 80, height: 22)
    #   frame from_bottom(another_view, width: 80, height: 22)
    def from_bottom(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :mid, y: :min })
    end

    # The first arg can be a window or a frame
    # @example
    #   frame from_bottom_right(width: 80, height: 22)
    #   frame from_bottom_right(another_view, width: 80, height: 22)
    def from_bottom_right(from_window=nil, f=nil)
      if from_window.is_a?(Hash)
        f = from_window
        from_window = nil
      end
      f ||= {}
      from_window ||= target.screen || NSScreen.mainScreen
      _calculate_frame(f, from: from_window, relative_to: { x: :max, y: :min })
    end

    # The first arg can be a window or a frame
    # @example
    def above(from_window, f={})
      _calculate_frame(f, from: from_window, relative_to: { x: :reset, y: :above })
    end

    # The first arg can be a window or a frame
    # @example
    def below(from_window, f={})
      _calculate_frame(f, from: from_window, relative_to: { x: :reset, y: :below })
    end

    # The first arg can be a window or a frame
    # @example
    def before(from_window, f={})
      _calculate_frame(f, from: from_window, relative_to: { x: :before, y: :reset })
    end
    alias left_of before

    # The first arg can be a window or a frame
    # @example
    def after(from_window, f={})
      _calculate_frame(f, from: from_window, relative_to: { x: :after, y: :reset })
    end
    alias right_of after

    # The first arg must be a view
    # @example
    def relative_to(from_window, f)
      _calculate_frame(f, from: from_window, relative_to: { x: :reset, y: :reset })
    end

  end
end
