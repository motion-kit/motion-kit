class TrackWindowController < NSWindowController
  attr_accessor :track

  def init
    super.tap do
      @track = Track.new

      @layout = TrackWindowLayout.new
      self.window = @layout.window
      self.prepare_views
    end
  end

  # I *cannot* figure out with this method never gets called!
  def loadWindow
    raise 'This should work!'
    @layout = TrackWindowLayout.new
    self.window = @layout.window

    self.prepare_views
  end

  def prepare_views
    @text_field = @layout.get(:text_field)
    @slider = @layout.get(:slider)
    @mute_button = @layout.get(:mute_button)

    @text_field.target = self
    @text_field.action = 'takeVolumeFrom:'

    @slider.target = self
    @slider.action = 'takeVolumeFrom:'

    @mute_button.target = self
    @mute_button.action = 'mute'
  end

  def mute
    @track.volume = 0.0
    self.update_interface
  end

  def takeVolumeFrom(sender)
    @track.volume = sender.intValue
    self.update_interface
  end

  def update_interface
    @text_field.intValue = @track.volume
    @slider.intValue = @track.volume
  end

end


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
