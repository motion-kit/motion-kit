describe MK::MenuLayout do

  before do
    @subject = MK::MenuLayout.new
  end

  it 'should return a menu from `default_root`' do
    @subject.default_root.should.be.kind_of(NSMenu)
  end

  it 'should be able to add a submenu' do
    menu = @subject.default_root
    item = NSMenuItem.alloc.initWithTitle('', action: nil, keyEquivalent: '')
    @subject.context(menu) do
      @subject.add_child(item)
    end
    menu.itemArray.should == [item]
  end

  it 'should be able to remove a submenu' do
    menu = @subject.default_root
    item = NSMenuItem.alloc.initWithTitle('', action: nil, keyEquivalent: '')
    menu.addItem(item)
    @subject.context(menu) do
      @subject.remove_child(item)
    end
    menu.itemArray.should == []
  end

  it 'should have a `root` method that accepts a title' do
    @subject.instance_variable_set(:@assign_root, true)
    menu = @subject.root('Title')
    menu.title.should == 'Title'
  end

  it 'should have a `create` method that returns a menu' do
    menu = @subject.create('Title')
    menu.title.should == 'Title'
  end

  it 'should have an `item` method that returns an NSMenuItem' do
    item = @subject.item('Title')
    item.title.should == 'Title'
  end

  it 'should have an `item` method that accepts a :key' do
    key = 'p'
    item = @subject.item('Title', key: key)
    item.keyEquivalent.should == key
  end

  it 'should have an `item` method that accepts a :keyEquivalent' do
    key = 'p'
    item = @subject.item('Title', keyEquivalent: key)
    item.keyEquivalent.should == key
  end

  it 'should have an `item` method that accepts a :mask' do
    mask = NSCommandKeyMask | NSAlternateKeyMask
    item = @subject.item('Title', mask: mask)
    item.keyEquivalentModifierMask.should == mask
  end

  it 'should have an `item` method that accepts an :action' do
    action = 'action:'
    item = @subject.item('Title', action: action)
    item.action.should == action.to_sym
  end

end
