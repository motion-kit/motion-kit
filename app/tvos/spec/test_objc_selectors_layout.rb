class TestObjcSelectorsLayout < MK::Layout

  def layout
    add UITableView do
      registerClass(TableViewCell, forCellReuseIdentifier: TableViewCell::ID)
    end
  end

end


class TableViewCell < UITableViewCell
  ID = 'TableViewCell'
end
