class TestCALayerLayout < MK::Layout

  def layout
    frame [[0, 0], [20, 30]]
    layer do
      frame :full

      add CAGradientLayer, :gradient do
        frame from_top width: '100%', height: '100% - 10'
        colors [UIColor.whiteColor, UIColor.blackColor]
      end
      add CALayer, :bottom do
        frame from_bottom width: '100%', height: 10
      end
    end
  end

end
