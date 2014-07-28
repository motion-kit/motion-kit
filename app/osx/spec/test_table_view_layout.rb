class TestTableColumnLayout < MK::Layout
  attr :table
  attr :column1
  attr :column2

  def layout
    @table = add NSTableView do
      @column1 = add_column 'foo' do
        title 'Foo'
      end

      @column2 = NSTableColumn.alloc.initWithIdentifier('bar')
      @column2.headerCell.stringValue = 'Bar'
      add_column @column2
    end
  end

end
