class TestTableColumnLayout < MK::Layout
  attr :table
  attr :column1
  attr :column2
  attr :column3

  def layout
    @table = add NSTableView do
      @column1 = add_column 'foo' do
        title 'Foo'
      end

      @column2 = NSTableColumn.alloc.initWithIdentifier('bar')
      @column2.headerCell.stringValue = 'Bar'
      add_column @column2

      @column3 = NSTableColumn.alloc.initWithIdentifier('quux')
      target.addTableColumn(@column3)

      column 'quux' do
        title 'Quux'
      end
    end
  end

end
