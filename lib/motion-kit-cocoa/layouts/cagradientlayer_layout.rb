# @provides MotionKit::CAGradientLayerLayout
# @requires MotionKit::CALayerLayout
# @requires MotionKit::TreeLayout
module MotionKit
  class CAGradientLayerLayout < CALayerLayout
    targets CAGradientLayer

    def colors(values)
      target.colors = values.map { |color| color.is_a?(MotionKit.color_class) ? color.CGColor : color }
    end

  end
end
