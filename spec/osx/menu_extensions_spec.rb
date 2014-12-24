describe 'NSMenuHelpers extensions' do

  before do
    @subject = MK::NSMenuHelpers.new
  end

  it 'should have an `app_name` method' do
    # @subject.app_name.should != 'MotionKit'
    # on 10.10, the app_name is totally buggy.
    @subject.app_name.should != nil
  end

  it 'should have an `app_menu` method' do
    menu = @subject.app_menu
    menu.should.be.kind_of(NSMenu)
    menu.itemArray.length.should == 10
  end

  it 'should assign a title via `app_menu`' do
    menu = @subject.app_menu('Title')
    menu.title.should == 'Title'
  end

  it 'should assign a title via options in `app_menu`' do
    menu = @subject.app_menu(title: 'Title')
    menu.title.should == 'Title'
  end

  it 'should be able to exclude items from `app_menu`' do
    menu = @subject.app_menu(exclude: [:about, :prefs])
    menu.itemArray.length.should == 6
  end

  it 'should be able to exclude a single item from `app_menu`' do
    menu = @subject.app_menu(exclude: :about)
    menu.itemArray.length.should == 8
  end


  it 'should have a `file_menu` method' do
    menu = @subject.file_menu
    menu.should.be.kind_of(NSMenu)
    menu.itemArray.length.should == 9
  end

  it 'should have a default title via `file_menu`' do
    menu = @subject.file_menu
    menu.title.should == 'File'
  end

  it 'should assign a title via `file_menu`' do
    menu = @subject.file_menu('Title')
    menu.title.should == 'Title'
  end

  it 'should assign a title via options in `file_menu`' do
    menu = @subject.file_menu(title: 'Title')
    menu.title.should == 'Title'
  end

  it 'should be able to exclude items from `file_menu`' do
    menu = @subject.file_menu(exclude: [:new, :open])
    menu.itemArray.length.should == 6
  end

  it 'should be able to exclude a single item from `file_menu`' do
    menu = @subject.file_menu(exclude: :new)
    menu.itemArray.length.should == 8
  end


  it 'should have a `window_menu` method' do
    menu = @subject.window_menu
    menu.should.be.kind_of(NSMenu)
    menu.itemArray.length.should == 4
  end

  it 'should have a default title via `window_menu`' do
    menu = @subject.window_menu
    menu.title.should == 'Window'
  end

  it 'should assign a title via `window_menu`' do
    menu = @subject.window_menu('Title')
    menu.title.should == 'Title'
  end

  it 'should assign a title via options in `window_menu`' do
    menu = @subject.window_menu(title: 'Title')
    menu.title.should == 'Title'
  end

  it 'should be able to exclude items from `window_menu`' do
    menu = @subject.window_menu(exclude: [:minimize, :zoom])
    menu.itemArray.length.should == 1
  end

  it 'should be able to exclude a single item from `window_menu`' do
    menu = @subject.window_menu(exclude: :minimize)
    menu.itemArray.length.should == 3
  end


  it 'should have a `help_menu` method' do
    menu = @subject.help_menu
    menu.should.be.kind_of(NSMenu)
    menu.itemArray.length.should == 1
  end

  it 'should have a default title via `help_menu`' do
    menu = @subject.help_menu
    menu.title.should == 'Help'
  end

  it 'should assign a title via `help_menu`' do
    menu = @subject.help_menu('Title')
    menu.title.should == 'Title'
  end

  it 'should assign a title via options in `help_menu`' do
    menu = @subject.help_menu(title: 'Title')
    menu.title.should == 'Title'
  end


  it 'should have a `separator_item` method' do
    item = @subject.separator_item
    item.should.be.kind_of(NSMenuItem)
  end

  it 'should have a `about_item` method' do
    item = @subject.about_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == ''
    item.action.should == 'orderFrontStandardAboutPanel:'.to_sym
  end

  it 'should have a `about_item` method with options' do
    item = @subject.about_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `preferences_item` method' do
    item = @subject.preferences_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == ','
    item.action.should == 'openPreferences:'.to_sym
  end

  it 'should have a `preferences_item` method with options' do
    item = @subject.preferences_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `services_item` method' do
    item = @subject.services_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == ''
  end

  it 'should have a `services_item` method with options' do
    item = @subject.services_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `hide_item` method' do
    item = @subject.hide_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'h'
    item.action.should == 'hide:'.to_sym
  end

  it 'should have a `hide_item` method with options' do
    item = @subject.hide_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `hide_others_item` method' do
    item = @subject.hide_others_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'h'
    item.action.should == 'hideOtherApplications:'.to_sym
    item.keyEquivalentModifierMask.should == NSCommandKeyMask | NSAlternateKeyMask
  end

  it 'should have a `hide_others_item` method with options' do
    item = @subject.hide_others_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `show_all_item` method' do
    item = @subject.show_all_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == ''
    item.action.should == 'unhideAllApplications:'.to_sym
  end

  it 'should have a `show_all_item` method with options' do
    item = @subject.show_all_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `quit_item` method' do
    item = @subject.quit_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'q'
    item.action.should == 'terminate:'.to_sym
  end

  it 'should have a `quit_item` method with options' do
    item = @subject.quit_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `new_item` method' do
    item = @subject.new_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'n'
    item.action.should == 'newDocument:'.to_sym
  end

  it 'should have a `new_item` method with options' do
    item = @subject.new_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `open_item` method' do
    item = @subject.open_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'o'
    item.action.should == 'openDocument:'.to_sym
  end

  it 'should have a `open_item` method with options' do
    item = @subject.open_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `close_item` method' do
    item = @subject.close_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'w'
    item.action.should == 'performClose:'.to_sym
  end

  it 'should have a `close_item` method with options' do
    item = @subject.close_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `save_item` method' do
    item = @subject.save_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 's'
    item.action.should == 'saveDocument:'.to_sym
  end

  it 'should have a `save_item` method with options' do
    item = @subject.save_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `save_as_item` method' do
    item = @subject.save_as_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'S'
    item.action.should == 'saveDocumentAs:'.to_sym
  end

  it 'should have a `save_as_item` method with options' do
    item = @subject.save_as_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `revert_to_save_item` method' do
    item = @subject.revert_to_save_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == ''
    item.action.should == 'revertDocumentToSaved:'.to_sym
  end

  it 'should have a `revert_to_save_item` method with options' do
    item = @subject.revert_to_save_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `page_setup_item` method' do
    item = @subject.page_setup_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'P'
    item.action.should == 'runPageLayout:'.to_sym
  end

  it 'should have a `page_setup_item` method with options' do
    item = @subject.page_setup_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `print_item` method' do
    item = @subject.print_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'p'
    item.action.should == 'printDocument:'.to_sym
  end

  it 'should have a `print_item` method with options' do
    item = @subject.print_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `minimize_item` method' do
    item = @subject.minimize_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == 'm'
    item.action.should == 'performMiniaturize:'.to_sym
  end

  it 'should have a `minimize_item` method with options' do
    item = @subject.minimize_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `zoom_item` method' do
    item = @subject.zoom_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == ''
    item.action.should == 'performMiniaturize:'.to_sym
  end

  it 'should have a `zoom_item` method with options' do
    item = @subject.zoom_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `bring_all_to_front_item` method' do
    item = @subject.bring_all_to_front_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == ''
    item.action.should == 'arrangeInFront:'.to_sym
  end

  it 'should have a `bring_all_to_front_item` method with options' do
    item = @subject.bring_all_to_front_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

  it 'should have a `help_item` method' do
    item = @subject.help_item
    item.should.be.kind_of(NSMenuItem)
    item.keyEquivalent.should == '?'
    item.action.should == 'showHelp:'.to_sym
  end

  it 'should have a `help_item` method with options' do
    item = @subject.help_item(key: 'a', action: 'action:')
    item.keyEquivalent.should == 'a'
    item.action.should == 'action:'.to_sym
  end

end
