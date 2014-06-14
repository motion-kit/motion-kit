# @provides module:MotionKit::OriginCalculator
module MotionKit

  module OriginCalculator

    def calculate_origin(view, dimension, amount, my_size=nil, full_view)
      my_size ||= view.frame.size
      if amount == :center
        x = calculate(view, :width, '50%', full_view) - my_size.width / 2.0
        y = calculate(view, :height, '50%', full_view) - my_size.height / 2.0
        return CGPoint.new(x, y)
      elsif amount.is_a?(Array) || amount.is_a?(Hash)
        if amount.is_a?(Hash)
          x, y, x_offset, y_offset = calculate_from_hash(view, dimension, amount, my_size)
        else
          x = amount[0]
          y = amount[1]
        end

        x = calculate(view, :width, x, full_view) + (x_offset || 0)
        y = calculate(view, :height, y, full_view) + (y_offset || 0)
        return CGPoint.new(x, y)
      else
        return amount
      end
    end

    def calculate_from_hash(view, dimension, amount, my_size=nil)
      if amount[:relative]
        calculate_relative_from_hash(view, dimension, amount, my_size)
      else
        calculate_absolute_from_hash(view, dimension, amount, my_size)
      end
    end

    def calculate_relative_from_hash(view, dimension, amount, my_size)
      x = amount[:x] || begin
        x = view.frame.origin.x
        x += my_size.width / 2.0 if dimension == :center
        x
      end

      y = amount[:y] || begin
        y = view.frame.origin.y
        y += my_size.height / 2.0 if dimension == :center
        y
      end

      x_offset = amount[:right] if amount.key?(:right)
      x_offset = -amount[:left] if amount.key?(:left)

      y_offset = amount[:down] if amount.key?(:down)
      y_offset = -amount[:up] if amount.key?(:up)
      y_offset = -y_offset if amount[:flipped]

      return x, y, x_offset, y_offset
    end

    def calculate_absolute_from_hash(view, dimension, amount, my_size)
      if amount.key?(:right)
        x_offset = -my_size.width
        x = amount[:right]
      elsif amount.key?(:x) || amount.key?(:left)
        x = amount[:x] || amount[:left]
      elsif dimension == :center
        x = view.frame.origin.x + (my_size.width / 2)
      else
        x = view.frame.origin.x
      end

      if amount.key?(:bottom)
        y_offset = -my_size.height
        y = amount[:bottom]
      elsif amount.key?(:y) || amount.key?(:top)
        y = amount[:y] || amount[:top]
      elsif dimension == :center
        y = view.frame.origin.y + (my_size.height / 2)
      else
        y = view.frame.origin.y
      end

      return x, y, x_offset, y_offset
    end

  end

end
