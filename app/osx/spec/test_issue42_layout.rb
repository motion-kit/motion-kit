class TestIssue42Layout < MK::WindowLayout

  def layout
    frame [[0, 0], [500, 400]]

    add NSButton, :cancel_button
    add NSButton, :ok_button
  end

  def cancel_button_style
    title 'Cancel'
    sizeToFit
    cell do
      bezelStyle NSRoundedBezelStyle
      alignment NSCenterTextAlignment
    end

    constraints do
      bottom_right.equals(:ok_button).minus(5)
    end
  end

end
