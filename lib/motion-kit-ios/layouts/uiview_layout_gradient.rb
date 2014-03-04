motion_require 'uiview_layout'

module MotionKit
  class UIViewLayout

    def gradient(gradient)
      gradient_layer = target.instance_variable_get(:@teacup_gradient_layer) || begin
        gradient_layer = CAGradientLayer.layer
        gradient_layer.frame = target.bounds
        target.layer.insertSublayer(gradient_layer, atIndex:0)
        gradient_layer
      end

      gradient.each do |key, value|
        case key.to_s
        when 'colors'
          colors = [value].flatten.collect { |color| color.is_a?(UIColor) ? color.CGColor : color }
          gradient_layer.colors = colors
        else
          gradient_layer.send("#{key}=", value)
        end
      end

      target.instance_variable_set(:@teacup_gradient_layer, gradient_layer)
    end

  end
end
