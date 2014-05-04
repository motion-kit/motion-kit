class TestLayerLayout < MK::CALayerLayout

  def layout
    add CALayer, do
      opacity 0.5
      background_color UIColor.whiteColor.CGColor
    end
    add CAGradientLayer do
      opacity 0.5
      colors [
        UIColor.whiteColor,
        UIColor.blackColor,
      ]
    end
    add CAShapeLayer do
      opacity 0.5
      square = UIBezierPath.bezierPathWithRect([[0, 0], [10, 10]])
      path square.CGPath
    end
  end

end
