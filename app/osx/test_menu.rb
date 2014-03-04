class TestMenu < MK::MenuLayout
  attr :foo
  attr :bar

  def layout
    add 'File' do
      add 'Open', action: 'open:', keyEquivalent: 'o'
      add 'Close', key: 'w', action: 'close:'
      add 'Foo', :foo_menu
      add 'Bar', :bar_menu do
        add 'Baz'
      end
    end

    add 'Views' do
      add 'Windows' do
        add 'First', keyEquivalent: '1', action: 'show_first_window:'
      end
    end

    add 'Things' do
      item_1 = NSMenuItem.alloc.initWithTitle('Thing 1', action: nil, keyEquivalent: '')
      add item_1
      item_2 = item('Thing 2')
      add item_2
      menu = NSMenu.alloc.initWithTitle('Menu')
      add menu do
        add 'Submenu'
      end
    end
  end

  def foo_menu_style
    @foo = target
  end

  def bar_menu_style
    @bar = target
  end

end


class TestRootMenu < MK::MenuLayout

  def layout
    root('Test Root') do
      add('File') do
        add 'Open', keyEquivalent: 'o', action: 'open:'
      end
    end
  end

end


class TestCreateMenu < MK::MenuLayout

  def some_menu
    create('Test Create') do
      add 'Submenu'
    end
  end

end
