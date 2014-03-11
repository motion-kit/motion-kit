describe TestCreateViaExtensionsMenu do

  before do
    @subject = TestCreateViaExtensionsMenu.new
  end

  it 'should have four items' do
    @subject.menu.itemArray.length.should == 4
  end

  it 'should have an application menu item' do
    app_item = @subject.menu.itemArray[0]
    app_item.should.not == nil
    app_item.should.be.kind_of(NSMenuItem)
    app_item.title.should == 'MotionKit'
  end

  it 'should have an application menu item with submenu' do
    app_item = @subject.menu.itemArray[0]
    app_menu = app_item.submenu
    app_menu.itemArray.length.should > 0
  end

  it 'should have a file menu item' do
    file_item = @subject.menu.itemArray[1]
    file_item.should.not == nil
    file_item.should.be.kind_of(NSMenuItem)
    file_item.title.should == 'File'
  end

  it 'should have a file menu item with submenu' do
    file_item = @subject.menu.itemArray[1]
    file_menu = file_item.submenu
    file_menu.itemArray.length.should > 0
  end

  it 'should have a window menu item' do
    window_item = @subject.menu.itemArray[2]
    window_item.should.not == nil
    window_item.should.be.kind_of(NSMenuItem)
    window_item.title.should == 'Window'
  end

  it 'should have a window menu item with submenu' do
    window_item = @subject.menu.itemArray[2]
    window_menu = window_item.submenu
    window_menu.itemArray.length.should > 0
  end

  it 'should have a help menu item' do
    help_item = @subject.menu.itemArray[3]
    help_item.should.not == nil
    help_item.should.be.kind_of(NSMenuItem)
    help_item.title.should == 'Help'
  end

  it 'should have a help menu item with submenu' do
    help_item = @subject.menu.itemArray[3]
    help_menu = help_item.submenu
    help_menu.itemArray.length.should > 0
  end

end
