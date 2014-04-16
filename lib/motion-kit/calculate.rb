module MotionKit
  module_function

  def calculate(view, dimension, amount, full_view=nil)
    if amount.is_a? Proc
      return view.instance_exec(&amount)
    elsif dimension == :origin
      return calculate_origin(view, dimension, amount, full_view)
    elsif dimension == :size
      return calculate_size(view, dimension, amount, full_view)
    elsif dimension == :frame
      return calculate_frame(view, dimension, amount, full_view)
    elsif amount == :full
      return calculate(view, dimension, '100%', full_view)
    elsif amount == :auto
      size_that_fits = view.intrinsicContentSize

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
        if amount.key?(:right)
          x_offset = -my_size.width
          x = amount.fetch(:right, view.frame.origin.x)
        else
          x = amount.fetch(:x, amount.fetch(:left, view.frame.origin.x))
        end

        if amount.key?(:bottom)
          y_offset = -my_size.height
          y = amount.fetch(:bottom, view.frame.origin.y)
        else
          y = amount.fetch(:y, amount.fetch(:top, view.frame.origin.y))
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

  def calculate_size(view, dimension, amount, full_view)
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
          size = view.intrinsicContentSize
          w = h * size.width / size.height
        elsif h == :scale
          w = calculate(view, :width, w, full_view)
          size = view.intrinsicContentSize
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
      return view.intrinsicContentSize
    elsif amount.is_a?(Symbol)
      raise "Unrecognized amount symbol #{amount.inspect} in MotionKit#calculate_size"
    else
      return amount
    end
  end

  def calculate_frame(view, dimension, amount, full_view)
    if amount.is_a?(Symbol)
      case amount
      when :full, :auto
        size = calculate_size(view, :size, amount, full_view)
        origin = [0, 0]
      when :center
        size = view.frame.size
        origin = calculate_origin(view, :origin, ['50%', '50%'], size, full_view)
        origin.x -= size.width / 2.0
        origin.y -= size.height / 2.0
      else
        raise "Unrecognized amount symbol #{amount.inspect} in MotionKit#calculate_frame"
      end

      return CGRect.new(origin, size)
    elsif amount.is_a?(Array)
      if amount.length == 2
        size = calculate_size(view, :size, amount[1], full_view)
        origin = calculate_origin(view, :origin, amount[0], size, full_view)
      elsif amount.length == 4
        size = calculate_size(view, :size, [amount[2], amount[3]], full_view)
        origin = calculate_origin(view, :size, [amount[0], amount[1]], size, full_view)
      else
        raise "Don't know what to do with frame value #{amount.inspect}"
      end

      return CGRect.new(origin, size)
    elsif amount.is_a?(Hash)
      if amount.key?(:size)
        size = calculate_size(view, :size, amount[:size], full_view)
      else
        size = calculate_size(view, :size, amount, full_view)
      end

      if amount.key?(:origin)
        origin = calculate_origin(view, :origin, amount[:origin], size, full_view)
      else
        origin = calculate_origin(view, :origin, amount, size, full_view)
      end

      return CGRect.new(origin, size)
    else
      return amount
    end
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
