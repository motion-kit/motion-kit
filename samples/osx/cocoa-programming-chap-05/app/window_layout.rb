class WindowLayout < MK::WindowLayout

  def layout
    frame [[335, 390], [402, 114]]
    styleMask NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
    contentMinSize [402, 92]
    contentMaxSize [402, 92]

    add NSButton, :start_button
    add NSButton, :stop_button
    add NSTextField, :text_field
  end

  def start_button_style
    frame [[310, 12], [78, 32]]

    cell do
      title 'Speak'
      bezelStyle NSRoundedBezelStyle
      alignment NSCenterTextAlignment
    end
  end

  def stop_button_style
    frame [[242, 12], [68, 32]]

    cell do
      title 'Stop'
      bezelStyle NSRoundedBezelStyle
      alignment NSCenterTextAlignment
    end
  end

  def text_field_style
    frame [[20, 50], [362, 22]]
    editable true
    selectable true
    bordered true
    bezeled true
    bezelStyle NSTextFieldSquareBezel
    font NSFont.fontWithName('Monaco', size: 12)

    cell do
      placeholderString 'What should I say?'
      alignment NSLeftTextAlignment
      scrollable false
    end

    string_value 'Peter Piper picked a peck of pickled peppers.'
  end

end
