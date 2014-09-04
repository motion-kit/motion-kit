describe MotionKit::NSTableViewHelpers do

  before do
    @layout = TestTableColumnLayout.new.build
  end

  it 'should have a column called "foo"' do
    column = @layout.table.tableColumnWithIdentifier('foo')
    column.should.be.kind_of(NSTableColumn)
  end

  it 'column1 should say "Foo"' do
    @layout.column1.headerCell.stringValue.should == 'Foo'
  end

  it 'should have a column called "bar"' do
    column = @layout.table.tableColumnWithIdentifier('bar')
    column.should.be.kind_of(NSTableColumn)
  end

  it 'column2 should say "Bar"' do
    @layout.column2.headerCell.stringValue.should == 'Bar'
  end

  it 'should have a column called "quux"' do
    column = @layout.table.tableColumnWithIdentifier('quux')
    column.should.be.kind_of(NSTableColumn)
  end

  it 'column3 should say "Quux"' do
    @layout.column3.headerCell.stringValue.should == 'Quux'
  end

end
