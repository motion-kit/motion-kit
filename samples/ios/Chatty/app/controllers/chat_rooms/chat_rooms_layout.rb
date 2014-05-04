class ChatRoomsLayout < MK::Layout
  view :table_view

  def layout
    @table_view = add UITableView, :table_view
  end

  def table_view_style
    backgroundColor = :clear.uicolor
    separatorStyle = UITableViewCellSeparatorStyleNone
    tableHeaderView = self.artist_header

    target.registerClass(SpinnerCell, forCellReuseIdentifier: SpinnerCell::ID)
  end

end
