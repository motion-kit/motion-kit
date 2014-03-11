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
