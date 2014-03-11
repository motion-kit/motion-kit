class TrackWindowLayout < MotionKit::WindowLayout

  def layout
    root(:window) do
      add(NSTextField, :text_field)
      add(NSSlider, :slider)
      add(NSButton, :mute_button)
    end
  end

  def window_style
    initial do
      title = NSBundle.mainBundle.infoDictionary['CFBundleName']
      frame [[240, 180], [280, 380]]
    end
  end

  def text_field_style
    initial do
      stringValue '5'
      alignment NSCenterTextAlignment
      bezelStyle NSTextFieldRoundedBezel
    end
    # todo: make these all relative to 'window.frame'
    frame([[90, 318], [100, 22]])
  end

  def slider_style
    initial do
      minValue 0
      maxValue 11
      intValue 5
    end
    # todo: make these all relative to 'window.frame'
    frame([[129, 62], [22, 236]])
  end

  def mute_button_style
    initial do
      title 'Mute'
      bezelStyle NSTexturedRoundedBezelStyle
    end
    # todo: make these all relative to 'window.frame'
    frame([[90, 20], [100, 22]])
  end

end
