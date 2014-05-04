# @provides MotionKit::CAGradientLayerLayout
# @requires MotionKit::CALayerLayout
# @requires MotionKit::ViewLayout
module MotionKit
  class CAGradientLayerLayout < CALayerLayout
    targets CAGradientLayer

    def colors(values)
      target.colors = values.map { |color| color.is_a?(UIColor) ? color.CGColor : color }
    end

  end
end
