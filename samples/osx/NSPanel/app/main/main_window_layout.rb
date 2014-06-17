class MainWindowLayout < MK::WindowLayout
  MAIN_WINDOW_IDENTIFIER = 'MAIN_WINDOW'

  def layout
    frame [[335, 390], [402, 114]], MAIN_WINDOW_IDENTIFIER
    styleMask NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
    contentMinSize [402, 92]

    add NSButton, :open_panel
  end

  def panel_layout
    @panel_layout ||= PanelLayout.new
  end

  def show_panel(button)
    NSApp.beginSheet(panel_layout.window,
      modalForWindow: self.window,
      modalDelegate: nil,
      didEndSelector: nil,
      contextInfo: nil)
  end

  def open_panel_style
    size [100, 32]
    center ['50%', '50%']
    autoresizing_mask :pin_to_center

    setTarget self
    setAction 'show_panel:'

    cell do
      title 'Speak'
      bezelStyle NSRoundedBezelStyle
      alignment NSCenterTextAlignment
    end
  end

end
