# @provides module:MotionKit::FrameCalculator
module MotionKit

  module FrameCalculator

    def calculate_frame(view, amount, full_view)
      if amount.is_a?(Symbol)
        calculate_frame_from_symbol(view, amount, full_view)
      elsif amount.is_a?(Array)
        calculate_frame_from_array(view, amount, full_view)
      elsif amount.is_a?(Hash)
        calculate_frame_from_hash(view, amount, full_view)
      else
        return amount
      end
    end

    def calculate_frame_from_symbol(view, amount, full_view)
      case amount
      when :full, :auto
        size = calculate_size(view, amount, full_view)
        origin = [0, 0]
      when :center
        size = view.frame.size
        origin = calculate_origin(view, :center, ['50%', '50%'], size, full_view)
        origin.x -= size.width / 2.0
        origin.y -= size.height / 2.0
      else
        raise "Unrecognized amount symbol #{amount.inspect} in MotionKit#calculate_frame"
      end

      return CGRect.new(origin, size)
    end

    def calculate_frame_from_array(view, amount, full_view)
      if amount.length == 2
        size = calculate_size(view, amount[1], full_view)
        origin = calculate_origin(view, :origin, amount[0], size, full_view)
      elsif amount.length == 4
        size = calculate_size(view, [amount[2], amount[3]], full_view)
        origin = calculate_origin(view, :origin, [amount[0], amount[1]], size, full_view)
      else
        raise "Don't know what to do with frame value #{amount.inspect}"
      end

      return CGRect.new(origin, size)
    end

    def calculate_frame_from_hash(view, amount, full_view)
      size = calculate_size(view, (amount[:size] || amount), full_view)

      if amount.key?(:center)
        origin = calculate_origin(view, :center, amount[:center], size, full_view)
        origin.x -= size.width / 2
        origin.y -= size.height / 2
      else
        origin = calculate_origin(view, :origin, (amount[:origin] || amount), size, full_view)
      end

      return CGRect.new(origin, size)
    end

  end

end
