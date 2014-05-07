class HelloLayout < MotionKit::Layout

  def layout
    # style the root layer by adding a gradient
    layer do
      add CAGradientLayer, :gradient_layer
    end

    add(UILabel, :label)
    add(UILabel, :footer)
  end

  def label_color
    UIColor.blueColor
  end

  def default_label_style
    text_color label_color
  end

  def gradient_layer_style
    frame superlayer.bounds
    initial do
      opacity 0.5
    end
    portrait do
      colors [
        UIColor.blackColor.CGColor,
        UIColor.darkGrayColor.CGColor,
      ]
    end
    landscape do
      colors [
        UIColor.darkGrayColor.CGColor,
        UIColor.lightGrayColor.CGColor,
      ]
    end
  end

  def label_style
    initial do
      default_label_style
      text 'Hello World!'
      background_color UIColor.whiteColor
    end

    portrait do
      frame [[100, 30], [100, 20]]
      # top 10
      # left 100
      # height 20
      # width 100
    end
    landscape do
      frame [[100, 60], [100, 20]]
      # top 40
      # left 100
      # height 20
      # width 100
    end
  end

  def footer_style
    initial do
      self.default_label_style
      text 'brought to you by MotionKit'
      background_color UIColor.lightGrayColor
    end

    size_to_fit
    portrait do
      top 440
      left 100
    end
    landscape do
      top 280
      left 260
    end
  end

end
