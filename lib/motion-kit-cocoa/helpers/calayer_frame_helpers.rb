# @requires MotionKit::CALayerHelpers
module MotionKit
  class CALayerHelpers

    def x(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.origin.x = MotionKit.calculate(target, :width, value, superview)
      target.frame = f
      return CGRectGetMinX(f)
    end
    alias left x

    def right(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.origin.x = MotionKit.calculate(target, :width, value, superview) - f.size.width
      target.frame = f
      return CGRectGetMaxX(f)
    end

    def center_x(value)
      c = target.center
      superview = target.superlayer || parent_layout.parent
      c.x = MotionKit.calculate(target, :width, value, superview)
      target.center = c
      return CGRectGetMidX(target.frame)
    end
    alias middle_x center_x

    def y(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.origin.y = MotionKit.calculate(target, :height, value, superview)
      target.frame = f
      return CGRectGetMinY(f)
    end
    alias top y

    def bottom(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.origin.y = MotionKit.calculate(target, :height, value, superview) - f.size.height
      target.frame = f
      return CGRectGetMaxY(f)
    end

    def center_y(value)
      c = target.center
      superview = target.superlayer || parent_layout.parent
      c.y = MotionKit.calculate(target, :height, value, superview)
      target.center = c
      return CGRectGetMidY(target.frame)
    end
    alias middle_y center_y

    def width(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.size.width = MotionKit.calculate(target, :width, value, superview)
      target.frame = f
      return CGRectGetWidth(f)
    end
    alias w width

    def height(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.size.height = MotionKit.calculate(target, :height, value, superview)
      target.frame = f
      return CGRectGetHeight(f)
    end
    alias h height

    def origin(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.origin = MotionKit.calculate(target, :origin, value, superview)
      target.frame = f
      return target.frame.origin
    end

    def center(value)
      superview = target.superlayer || parent_layout.parent
      target.center = MotionKit.calculate(target, :center, value, superview)
      return target.center
    end
    alias middle center

    def size(value)
      f = target.frame
      superview = target.superlayer || parent_layout.parent
      f.size = MotionKit.calculate(target, :size, value, superview)
      target.frame = f
      return target.frame.size
    end

    def frame(value)
      superview = target.superlayer || parent_layout.parent
      target.frame = MotionKit.calculate(target, :frame, value, superview)
      return target.frame
    end

    def _calculate_frame(f, from: from_layer, relative_to: point)
      if from_layer.is_a?(Symbol)
        from_layer = self.get_view(from_layer)
      end

      from_layer_size = from_layer.frame.size
      o = from_layer.convertPoint([0, 0], toLayer: target.superlayer)

      calculate_layer = CALayer.layer
      calculate_layer.frame = [[0, 0], target.frame.size]

      if f.is_a?(Hash)
        f = f.merge(relative: true)
      end
      f = MotionKit.calculate(calculate_layer, :frame, f, target.superlayer || parent_layout.parent)
      f.origin.x += o.x
      f.origin.y += o.y

      case point[:x]
      when :min, :reset
        # pass
      when :mid
        f.origin.x += (from_layer_size.width - f.size.width) / 2.0
      when :max
        f.origin.x += from_layer_size.width - f.size.width
      when :before
        f.origin.x -= f.size.width
      when :after
        f.origin.x += from_layer_size.width
      else
        f.origin.x += point[:x]
      end

      case point[:y]
      when :min, :reset
        # pass
      when :mid
        f.origin.y += (from_layer_size.height - f.size.height) / 2.0
      when :max
        f.origin.y += from_layer_size.height - f.size.height
      when :above
        f.origin.y -= f.size.height
      when :below
        f.origin.y += from_layer_size.height
      else
        f.origin.y += point[:y]
      end

      return f
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_top_left(width: 80, height: 22)
    #   frame from_top_left(another_layer, width: 80, height: 22)
    def from_top_left(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :min, y: :min })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_top(width: 80, height: 22)
    #   frame from_top(another_layer, width: 80, height: 22)
    def from_top(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :mid, y: :min })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_top_right(width: 80, height: 22)
    #   frame from_top_right(another_layer, width: 80, height: 22)
    def from_top_right(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :max, y: :min })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_left(width: 80, height: 22)
    #   frame from_left(another_layer, width: 80, height: 22)
    def from_left(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :min, y: :mid })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_center(width: 80, height: 22)
    #   frame from_center(another_layer, width: 80, height: 22)
    def from_center(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :mid, y: :mid })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_right(width: 80, height: 22)
    #   frame from_right(another_layer, width: 80, height: 22)
    def from_right(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :max, y: :mid })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_bottom_left(width: 80, height: 22)
    #   frame from_bottom_left(another_layer, width: 80, height: 22)
    def from_bottom_left(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :min, y: :max })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_bottom(width: 80, height: 22)
    #   frame from_bottom(another_layer, width: 80, height: 22)
    def from_bottom(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :mid, y: :max })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame from_bottom_right(width: 80, height: 22)
    #   frame from_bottom_right(another_layer, width: 80, height: 22)
    def from_bottom_right(from_layer=nil, f=nil)
      if from_layer.is_a?(Hash)
        f = from_layer
        from_layer = nil
      end
      f ||= {}
      from_layer ||= target.superlayer
      _calculate_frame(f, from: from_layer, relative_to: { x: :max, y: :max })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame above(layer, [[0, 0], [100, 20]])
    #   frame above(:layer, x: 0, y: 0, width: 100, height: 20)
    #   frame above(:layer, down: 0, right: 0, width: 100, height: 20)
    def above(from_layer, f={})
      _calculate_frame(f, from: from_layer, relative_to: { x: :reset, y: :above })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame below(layer, [[0, 0], [100, 20]])
    #   frame below(:layer, x: 0, y: 0, width: 100, height: 20)
    #   frame below(:layer, down: 0, right: 0, width: 100, height: 20)
    def below(from_layer, f={})
      _calculate_frame(f, from: from_layer, relative_to: { x: :reset, y: :below })
    end

    # The first arg can be a layer or a frame
    # @example
    #   frame before(layer, [[0, 0], [100, 20]])
    #   frame before(:layer, x: 0, y: 0, width: 100, height: 20)
    #   frame before(:layer, down: 0, right: 0, width: 100, height: 20)
    def before(from_layer, f={})
      _calculate_frame(f, from: from_layer, relative_to: { x: :before, y: :reset })
    end
    alias left_of before

    # The first arg can be a layer or a frame
    # @example
    #   frame after(layer, [[0, 0], [100, 20]])
    #   frame after(:layer, x: 0, y: 0, width: 100, height: 20)
    #   frame after(:layer, down: 0, right: 0, width: 100, height: 20)
    def after(from_layer, f={})
      _calculate_frame(f, from: from_layer, relative_to: { x: :after, y: :reset })
    end
    alias right_of after

    # The first arg must be a layer
    # @example
    #   frame relative_to(layer, [[0, 0], [100, 20]])
    #   frame relative_to(:layer, x: 0, y: 0, width: 100, height: 20)
    #   frame relative_to(:layer, down: 0, right: 0, width: 100, height: 20)
    def relative_to(from_layer, f)
      _calculate_frame(f, from: from_layer, relative_to: { x: :reset, y: :reset })
    end

  end
end
