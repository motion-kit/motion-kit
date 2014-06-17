class PanelLayout < MK::WindowLayout

  def layout
    root(NSPanel, :panel) do
      add NSButton, :close_panel
    end
  end

  def panel_style
    frame [[0, 0], [320, 480]]
    p target: target
  end

  def close_panel(button)
    NSApp.endSheet(self.window)
    self.window.orderOut(button)
  end

  def close_panel_style
    size [100, 32]
    center ['50%', '50%']
    autoresizing_mask :pin_to_center

    setTarget self
    setAction 'close_panel:'

    cell do
      title 'Close'
      bezelStyle NSRoundedBezelStyle
      alignment NSCenterTextAlignment
    end
  end

end
