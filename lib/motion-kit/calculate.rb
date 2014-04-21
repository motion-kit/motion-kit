module MotionKit
  module_function

  def calculate(view, dimension, amount, full_view=nil)
    if amount.is_a? Proc
      return view.instance_exec(&amount)
    elsif dimension == :origin || dimension == :center
      return calculate_origin(view, dimension, amount, nil, full_view)
    elsif dimension == :size
      return calculate_size(view, amount, full_view)
    elsif dimension == :frame
      return calculate_frame(view, amount, full_view)
    elsif amount == :full
      return calculate(view, dimension, '100%', full_view)
    elsif amount == :auto
      size_that_fits = intrinsic_size(view)

      return case dimension
      when :width
        return size_that_fits.width
      when :height
        return size_that_fits.height
      end
    elsif amount.is_a?(String) && amount.include?('%')
      full_view ||= view.superview
      unless full_view
        raise NoSuperviewError.new("Cannot calculate #{amount}% of #{dimension.inspect} because view #{view} has no superview.")
      end
      calc = Calculator.scan(amount)

      factor = calc.factor
      constant = calc.constant

      return case dimension
      when :width
        return (view.superview.frame.size.width * factor + constant).round
      when :height
        return (view.superview.frame.size.height * factor + constant).round
      else
        raise "Unknown dimension #{dimension}"
      end
    else
      return amount
    end
  end

  def calculate_origin(view, dimension, amount, my_size=nil, full_view)
    my_size ||= view.frame.size

    if amount == :center
      x = calculate(view, :width, '50%', full_view) - my_size.width / 2.0
      y = calculate(view, :height, '50%', full_view) - my_size.height / 2.0
      return CGPoint.new(x, y)
    elsif amount.is_a?(Array) || amount.is_a?(Hash)
      x_offset = 0
      y_offset = 0

      if amount.is_a?(Hash)
        if amount.fetch(:relative, false)
          if amount.key?(:x)
            x = amount[:x]
          else
            x = view.frame.origin.x
            if dimension == :center
              x += my_size.width / 2.0
            end
          end

          if amount.key?(:y)
            y = amount[:y]
          else
            y = view.frame.origin.y
            if dimension == :center
              y += my_size.height / 2.0
            end
          end

          if amount.key?(:right)
            x_offset = amount[:right]
          elsif amount.key?(:left)
            x_offset = -amount[:left]
          end

          if amount.key?(:down)
            y_offset = amount[:down]
          elsif amount.key?(:up)
            y_offset = -amount[:up]
          end
          y_offset = -y_offset if amount[:flipped]
        else
          if amount.key?(:right)
            x_offset = -my_size.width
            x = amount.fetch(:right, view.frame.origin.x)
          elsif amount.key?(:x) || amount.key?(:left)
            x = amount[:x] || amount[:left]
          elsif dimension == :center
            x = view.frame.origin.x
            x += my_size.width / 2
          else
            x = view.frame.origin.x
          end

          if amount.key?(:bottom)
            y_offset = -my_size.height
            y = amount.fetch(:bottom, view.frame.origin.y)
          elsif amount.key?(:y) || amount.key?(:top)
            y = amount[:y] || amount[:top]
          elsif dimension == :center
            y = view.frame.origin.y
            y += my_size.height / 2
          else
            y = view.frame.origin.y
          end
        end
      else
        x = amount[0]
        y = amount[1]
      end

      x = calculate(view, :width, x, full_view) + x_offset
      y = calculate(view, :height, y, full_view) + y_offset
      return CGPoint.new(x, y)
    else
      return amount
    end
  end

  def calculate_size(view, amount, full_view)
    if amount.is_a?(Array) || amount.is_a?(Hash)
      if amount.is_a?(Hash)
        w = amount.fetch(:w, amount.fetch(:width, view.frame.size.width))
        h = amount.fetch(:h, amount.fetch(:height, view.frame.size.height))
      else
        w = amount[0]
        h = amount[1]
      end

      # scaling is handled a little differently, because it is dependent on
      # the other amount and the intrinsic size.
      if w == :scale || h == :scale
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
      else
        w = calculate(view, :width, w, full_view)
        h = calculate(view, :height, h, full_view)
      end

      return CGSize.new(w, h)
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

  def calculate_frame(view, amount, full_view)
    if amount.is_a?(Symbol)
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
    elsif amount.is_a?(Array)
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
    elsif amount.is_a?(Hash)
      if amount.key?(:size)
        size = calculate_size(view, amount[:size], full_view)
      else
        size = calculate_size(view, amount, full_view)
      end

      if amount.key?(:center)
        origin = calculate_origin(view, :center, amount[:center], size, full_view)
        origin.x -= size.width / 2
        origin.y -= size.height / 2
      elsif amount.key?(:origin)
        origin = calculate_origin(view, :origin, amount[:origin], size, full_view)
      else
        origin = calculate_origin(view, :origin, amount, size, full_view)
      end

      return CGRect.new(origin, size)
    else
      return amount
    end
  end

  def intrinsic_size(view)
    size_that_fits = view.intrinsicContentSize
    if size_that_fits.width == MotionKit.no_intrinsic_metric
      size_that_fits.width = 0
    end
    if size_that_fits.height == MotionKit.no_intrinsic_metric
      size_that_fits.height = 0
    end
    return size_that_fits
  end

  class Calculator
    attr_accessor :factor, :constant

    def self.memo
      @memo ||= {}
    end

    def self.scan(amount)
      amount = amount.gsub(' ', '')
      return Calculator.memo[amount] if Calculator.memo[amount]

      calc = Calculator.new

      location = amount.index '%'
      if location
        calc.factor = amount.slice(0, location).to_f / 100.0
        location += 1
      else
        calc.factor = 0
        location = 0
      end
      calc.constant = amount.slice(location, amount.size).to_f

      Calculator.memo[amount] = calc
      return calc
    end

  end

end
