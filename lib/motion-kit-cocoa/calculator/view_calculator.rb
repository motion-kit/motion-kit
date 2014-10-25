# @requires MotionKit::Calculator
# @requires module:MotionKit::OriginCalculator
# @requires module:MotionKit::SizeCalculator
# @requires module:MotionKit::FrameCalculator
# @provides MotionKit::ViewCalculator
module MotionKit
  class ViewCalculator
    extend MotionKit::OriginCalculator
    extend MotionKit::SizeCalculator
    extend MotionKit::FrameCalculator

    def self.calculate(view, dimension, amount, full_view=nil)
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
        if not full_view
          if view.is_a?(CALayer)
            full_view = view.superlayer
          elsif view.respond_to?(:superview)
            full_view = view.superview
          end

          if not full_view
            raise NoSuperviewError.new("Cannot calculate #{amount.inspect} of #{dimension.inspect} because view #{view} has no superview.")
          end
        end
        calc = Calculator.scan(amount)

        raise "Unknown dimension #{dimension}" unless [:width, :height].include?(dimension)
        return (full_view.frame.size.send(dimension) * calc.factor + calc.constant).round
      else
        return amount
      end
    end

    def self.intrinsic_size(view)
      size_that_fits = view.intrinsicContentSize
      if size_that_fits.width == MotionKit.no_intrinsic_metric
        size_that_fits.width = 0
      end
      if size_that_fits.height == MotionKit.no_intrinsic_metric
        size_that_fits.height = 0
      end
      return size_that_fits
    end

  end

end
