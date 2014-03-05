describe TestMenuExtensions do

  before do
    @subject = MK::NSMenuLayout.new
  end

  it 'should have an `app_name` method' do
    @subject.app_name.should == 'MotionKit'
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
  end

  it 'should have a `about_item` method' do
  end

  it 'should have a `preferences_item` method' do
  end

  it 'should have a `services_item` method' do
  end

  it 'should have a `hide_item` method' do
  end

  it 'should have a `hide_others_item` method' do
  end

  it 'should have a `show_all_item` method' do
  end

  it 'should have a `quit_item` method' do
  end

  it 'should have a `new_item` method' do
  end

  it 'should have a `open_item` method' do
  end

  it 'should have a `close_item` method' do
  end

  it 'should have a `save_item` method' do
  end

  it 'should have a `save_as_item` method' do
  end

  it 'should have a `revert_to_save_item` method' do
  end

  it 'should have a `page_setup_item` method' do
  end

  it 'should have a `print_item` method' do
  end

  it 'should have a `minimize_item` method' do
  end

  it 'should have a `zoom_item` method' do
  end

  it 'should have a `bring_all_to_front_item` method' do
  end

  it 'should have a `help_item` method' do
  end

end
