# @provides MotionKit::CAGradientLayerHelpers
# @requires MotionKit::CALayerHelpers
# @requires MotionKit::TreeLayout
module MotionKit
  class CAGradientLayerHelpers < CALayerHelpers
    targets CAGradientLayer

    def colors(values)
      target.colors = values.map { |color| color.is_a?(MotionKit.color_class) ? color.CGColor : color }
    end

  end
end
