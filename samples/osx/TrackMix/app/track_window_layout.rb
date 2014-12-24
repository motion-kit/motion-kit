class TrackWindowLayout < MotionKit::WindowLayout
  view :text_field
  view :slider
  view :mute_button

  def layout
    root(:window) do
      # add(QuartzView, :bg_view)
      add(NSTextField, :text_field)
      add(NSSlider, :slider)
      add(NSButton, :mute_button)
    end
  end

  def window_style
    title NSBundle.mainBundle.infoDictionary['CFBundleName']
    width 280
    height 380
    frame from_center
    min_size [180, 250]
    # frame_autosave_name('main window')
  end

  def bg_view_style
    constraints do
      top_left.equals(:superview)
      size.equals(:superview)
    end
  end

  def text_field_style
    intValue 5
    alignment NSCenterTextAlignment
    bezelStyle NSTextFieldRoundedBezel

    constraints do
      height 22
      top.equals(:superview).plus(20)
      left.equals(:superview).plus(20)
      right.equals(:superview).minus(20)
    end
  end

  def slider_style
    minValue 0
    maxValue 11
    intValue 5

    constraints do
      center_x(:superview)
      top.equals(:text_field, :bottom).plus(20)
      bottom.equals(:mute_button, :top).minus(20)
    end
    # frame([[129, 62], [22, 236]])
  end

  def mute_button_style
    title 'Mute'
    bezelStyle NSTexturedRoundedBezelStyle

    constraints do
      bottom.equals(:superview).minus(20)
      width 100
      height 22
      center_x.equals(:superview)
    end
  end

end
