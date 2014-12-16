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
    registerClass(CustomTableCell, forCellReuseIdentifier: 'identifier')

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
    cell.headline = "#{index_path.row + 1}"
    cell
  end

end


class CustomTableCell < UITableViewCell
  attr_accessor :headline
  attr_accessor :sub_headline
  attr_accessor :price

  def initWithStyle(style, reuseIdentifier:identifier)
    super
    @layout = CustomTableCellLayout.new(root: self)
    @layout.build
    self
  end

  def headline=(new_text)
    p layout: "0x#{@layout.object_id.to_s(16)}"
    headline = @layout.get(:headline)
    headline.text = new_text
  end
end

class CustomTableCellLayout < MK::Layout

  def layout
    content_view do
      add UILabel, :headline
    end
  end

  def headline_style
    background_color UIColor.blueColor
    constraints do
      left.equals(:superview)
      right.equals(:superview)
      top.equals(:superview)
      bottom.equals(:superview)
    end
  end

end
