class WindowLayout < MK::WindowLayout

  def layout
    frame [[100, 100], [480, 360]], 'WindowLayout'

    add NSScrollView, :table_scroll_view do
      document_view add NSTableView, :table_view
      has_vertical_scroller true
    end
  end

  def table_scroll_view_style
    frame v.superview.bounds
    autoresizing_mask NSViewWidthSizable | NSViewHeightSizable
  end

  def table_view_style
    uses_alternating_row_background_colors true
    row_height 24
    parent_bounds = v.superview.bounds
    frame parent_bounds

    add_column('name') do
      title 'Name'
      min_width 102
      width 170
      resizing_mask NSTableColumnUserResizingMask
    end
    add_column('role') do
      title 'Role'
      min_width 102
      width parent_bounds.size.width - 170
      resizingMask NSTableColumnAutoresizingMask
    end
  end

end
