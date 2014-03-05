describe TestMenu do

  before do
    @subject = TestMenu.new
    @menu = @subject.view
  end

  it 'should create a menu' do
    @menu.should.not == nil
    @menu.should.be.kind_of(NSMenu)
  end

  it 'should return the menu via `menu`' do
    @subject.menu.should == @menu
  end

  it 'should have three items' do
    @subject.menu.itemArray.length.should == 3
  end

  it 'should have a "File" item' do
    file_item = @subject.menu.itemArray[0]
    file_item.should.not == nil
    file_item.should.be.kind_of(NSMenuItem)
    file_item.title.should == 'File'
  end

  it 'should have a "File" menu with submenu' do
    file_item = @subject.menu.itemArray[0]
    file_menu = file_item.submenu
    file_menu.itemArray.length.should > 0
  end

  it 'should have a "File" menu with an "Open" item' do
    file_item = @subject.menu.itemArray[0]
    file_menu = file_item.submenu
    open_menu = file_menu.itemArray[0]
    open_menu.title.should == 'Open'
    open_menu.keyEquivalent.should == 'o'
  end

  it 'should have a "File" menu with an "Close" item' do
    file_item = @subject.menu.itemArray[0]
    file_menu = file_item.submenu
    close_menu = file_menu.itemArray[1]
    close_menu.title.should == 'Close'
    close_menu.keyEquivalent.should == 'w'
  end

  it 'should have a "File" menu with an "Foo" item' do
    file_item = @subject.menu.itemArray[0]
    file_menu = file_item.submenu
    foo_menu = file_menu.itemArray[2]
    foo_menu.title.should == 'Foo'
    @subject.foo.should == foo_menu
  end

  it 'should have a "File" menu with an "Bar" item' do
    file_item = @subject.menu.itemArray[0]
    file_menu = file_item.submenu
    bar_menu = file_menu.itemArray[3]
    bar_menu.title.should == 'Bar'
    @subject.bar.should == bar_menu.submenu
  end

  it 'should have a "Views" item' do
    views_item = @subject.menu.itemArray[1]
    views_item.should.not == nil
    views_item.should.be.kind_of(NSMenuItem)
    views_item.title.should == 'Views'
  end

  it 'should have a "Views" menu with submenu' do
    views_item = @subject.menu.itemArray[1]
    views_menu = views_item.submenu
    views_menu.itemArray.length.should > 0
  end

  it 'should have a "Views" menu with a "Windows" submenu' do
    views_item = @subject.menu.itemArray[1]
    views_menu = views_item.submenu
    open_menu = views_menu.itemArray[0]
    open_menu.should.not == nil
    open_menu.title.should == 'Windows'
  end

  it 'should have a "Views" menu with a "Windows" submenu with items' do
    views_item = @subject.menu.itemArray[1]
    views_menu = views_item.submenu
    open_menu = views_menu.itemArray[0]
    open_menu.submenu.should.not == nil
    open_menu.submenu.should.be.kind_of(NSMenu)
    open_menu.submenu.itemArray.length.should > 0
  end

  it 'should have a "Views" menu with a "Windows" submenu with "First" item' do
    views_item = @subject.menu.itemArray[1]
    views_menu = views_item.submenu
    open_menu = views_menu.itemArray[0]
    first_item = open_menu.submenu.itemArray[0]
    first_item.title.should == 'First'
    first_item.keyEquivalent.should == '1'
  end

  it 'should have a "Things" item' do
    things_item = @subject.menu.itemArray[2]
    things_item.should.not == nil
    things_item.should.be.kind_of(NSMenuItem)
    things_item.title.should == 'Things'
  end

  it 'should have a "Things" menu with submenu' do
    things_item = @subject.menu.itemArray[2]
    things_menu = things_item.submenu
    things_menu.itemArray.length.should > 0
  end

  it 'should have a "Things" menu with a "Thing 1" submenu' do
    things_item = @subject.menu.itemArray[2]
    things_menu = things_item.submenu
    open_menu = things_menu.itemArray[0]
    open_menu.title.should == 'Thing 1'
  end

  it 'should have a "Things" menu with a "Thing 2" submenu' do
    things_item = @subject.menu.itemArray[2]
    things_menu = things_item.submenu
    open_menu = things_menu.itemArray[1]
    open_menu.title.should == 'Thing 2'
  end

  it 'should have a "Things" menu with a "Menu" submenu' do
    things_item = @subject.menu.itemArray[2]
    things_menu = things_item.submenu
    menu_menu = things_menu.itemArray[2]
    menu_menu.should.not == nil
    menu_menu.title.should == 'Menu'
  end

  it 'should have a "Things" menu with a "Menu" submenu with items' do
    things_item = @subject.menu.itemArray[2]
    things_menu = things_item.submenu
    menu_menu = things_menu.itemArray[2]
    menu_menu.submenu.should.not == nil
    menu_menu.submenu.should.be.kind_of(NSMenu)
    menu_menu.submenu.itemArray.length.should > 0
  end

  it 'should have a "Things" menu with a "Menu" submenu with "Submenu" item' do
    things_item = @subject.menu.itemArray[2]
    things_menu = things_item.submenu
    menu_menu = things_menu.itemArray[2]
    submenu_item = menu_menu.submenu.itemArray[0]
    submenu_item.title.should == 'Submenu'
  end

end
