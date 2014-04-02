class WindowLayout < MK::WindowLayout

  def layout
    frame [[335, 390], [340, 139]]
    styleMask NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
    contentMinSize [340, 117]
    contentMaxSize [340, 117]

    add NSButton, :seed_button
    add NSButton, :generate_button
    add NSTextField, :number_field
  end

  def seed_button_style
    frame [[14, 69], [312, 32]]
    cell do
      title 'Seed random number generator using time'
      bezelStyle NSRoundedBezelStyle
      alignment NSCenterTextAlignment
    end
  end

  def generate_button_style
    frame [[69, 37], [203, 32]]
    cell do
      bezelStyle NSRoundedBezelStyle
      title 'Generate random number'
      alignment NSCenterTextAlignment
    end
  end

  def number_field_style
    frame [[14, 20], [312, 17]]
    editable false
    selectable false
    bordered false
    font NSFont.fontWithName('Monaco', size: 12)

    cell do
      alignment NSCenterTextAlignment
      scrollable false
      drawsBackground false
    end

    initial do
      string_value 'Press Generate'
    end
  end

end
