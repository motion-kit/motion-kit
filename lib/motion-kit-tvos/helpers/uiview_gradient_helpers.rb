# @requires MotionKit::UIViewHelpers
module MotionKit
  class UIViewHelpers

    # gradient colors:
    def gradient(&block)
      gradient_layer = target.motion_kit_meta[:motionkit_gradient_layer] || begin
        gradient_layer = CAGradientLayer.layer
        gradient_layer.frame = CGRect.new([0, 0], target.frame.size)
        target.layer.insertSublayer(gradient_layer, atIndex:0)
        target.motion_kit_meta[:motionkit_gradient_layer] = gradient_layer

        gradient_layer
      end

      context(gradient_layer, &block)

      gradient_layer
    end

  end
end
