class MainWindowController < NSWindowController

  def layout
    @layout ||= MainWindowLayout.new
  end

  def init
    super.tap do
      self.window = layout.window
    end
  end

end
