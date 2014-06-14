# @requires MotionKit::Calculator
# @requires MotionKit::OriginCalculator
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
      return intrinsic_size(view).send(dimension) # :left or :right
    elsif amount.is_a?(String) && amount.include?('%')
      full_view ||= view.superview || begin
        raise NoSuperviewError.new("Cannot calculate #{amount}% of #{dimension.inspect} because view #{view} has no superview.")
      end
      calc = Calculator.scan(amount)

      factor = calc.factor
      constant = calc.constant

      raise "Unknown dimension #{dimension}" unless [:width, :height].include?(dimension)
      return (full_view.frame.size.send(dimension) * factor + constant).round
    else
      return amount
    end
  end

  def calculate_origin(view, dimension, amount, my_size=nil, full_view)
    if amount == :center
      x = calculate(view, :width, '50%', full_view) - my_size.width / 2.0
      y = calculate(view, :height, '50%', full_view) - my_size.height / 2.0
    elsif amount.is_a?(Array) || amount.is_a?(Hash)
      calc = OriginCalculator.new(view, dimension, amount, my_size, full_view)
      x = calculate(view, :width, calc.x, full_view) + calc.x_offset
      y = calculate(view, :height, calc.y, full_view) + calc.y_offset
    else
      return amount
    end
    return CGPoint.new(x, y)
  end

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
