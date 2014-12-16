class MainLayout < MK::Layout

  def layout
    add UITableView, :table
  end

  def dealloc
    NSLog("=============== main_layout.rb line #{__LINE__} ===============")
    super
  end

  def table_style
    delegate self
    dataSource self
    registerClass(Cell, forCellReuseIdentifier: 'identifier')

    constraints do
      left.equals(self.view)
      right.equals(self.view)
      top.equals(self.view)
      bottom.equals(self.view)
    end
  end

  def tableView(table_view, numberOfRowsInSection: section)
    100
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    cell = table_view.dequeueReusableCellWithIdentifier('identifier')
    cell.text = "#{index_path.row + 1}"
    cell
  end

end


class Cell < UITableViewCell

  def initWithStyle(style, reuseIdentifier: identifier)
    super
    @layout = CellLayout.new(root: self).build
    self
  end

  def dealloc
    NSLog("=============== main_layout.rb line #{__LINE__} ===============")
    super
  end

  def text=(value)
    @layout.get(:label).text = value
  end

end


class CellLayout < MK::Layout

  def layout
    add UILabel, :label
  end

  def dealloc
    NSLog("=============== main_layout.rb line #{__LINE__} ===============")
    super
  end

  def label_style
    background_color UIColor.blueColor
    constraints do
      left.equals(:superview)
      right.equals(:superview)
      top.equals(:superview)
      bottom.equals(:superview)
    end
  end

end
