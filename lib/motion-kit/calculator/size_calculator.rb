# @provides module:MotionKit::SizeCalculator
module MotionKit

  module SizeCalculator

    def calculate_size(view, amount, full_view)
      if amount.is_a?(Array) || amount.is_a?(Hash)
        calculate_size_from_multiple(view, amount, full_view)
      elsif amount == :full
        w = calculate(view, :width, '100%', full_view)
        h = calculate(view, :height, '100%', full_view)
        return CGSize.new(w, h)
      elsif amount == :auto
        return intrinsic_size(view)
      elsif amount.is_a?(Symbol)
        raise "Unrecognized amount symbol #{amount.inspect} in MotionKit#calculate_size"
      else
        return amount
      end
    end

    def calculate_size_from_multiple(view, amount, full_view)
      w, h = resolve_width_and_height(view, amount)

      if w == :scale || h == :scale
        w, h = calculate_scaled_width_height(w, h, view, full_view)
      else
        w = calculate(view, :width, w, full_view)
        h = calculate(view, :height, h, full_view)
      end

      return CGSize.new(w, h)
    end

    def calculate_scaled_width_height(w, h, view, full_view)
      # scaling is handled a little differently, because it is dependent on
      # the other amount and the intrinsic size.
      if w == :scale && h == :scale
        raise "Either width or height can be :scale, but not both"
      elsif w == :scale
        h = calculate(view, :height, h, full_view)
        size = intrinsic_size(view)
        w = h * size.width / size.height
      elsif h == :scale
        w = calculate(view, :width, w, full_view)
        size = intrinsic_size(view)
        h = w * size.height / size.width
      end
      return w, h
    end

    def resolve_width_and_height(view, amount)
      if amount.is_a?(Hash)
        w = amount[:w] || amount[:width]  || view.frame.size.width
        h = amount[:h] || amount[:height] || view.frame.size.height
      else
        w = amount[0]
        h = amount[1]
      end
      return w, h
    end

  end

end
