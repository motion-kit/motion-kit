class MainMenu < MK::MenuLayout

  def layout
    add app_menu

    # add file_menu
    add 'File' do
      add new_item
      add open_item
      add separator_item
      add close_item
      add save_item
      add revert_to_save_item
      add separator_item
      add page_setup_item
      add print_item
    end

    # add edit_menu
    add 'Edit' do
      add item('Undo', action: 'undo:', keyEquivalent: 'z')
      add item('Redo', action: 'redo:', keyEquivalent: 'Z')
      add NSMenuItem.separatorItem
      add item('Cut', action: 'cut:', keyEquivalent: 'x')
      add item('Copy', action: 'copy:', keyEquivalent: 'c')
      add item('Paste', action: 'paste:', keyEquivalent: 'v')
      item = add item('Paste and Match Style', action: 'pasteAsPlainText:', keyEquivalent: 'V')
      item.keyEquivalentModifierMask = NSCommandKeyMask|NSAlternateKeyMask
      add item('Delete', action: 'delete:', keyEquivalent: '')
      add item('Select All', action: 'selectAll:', keyEquivalent: 'a')
    end

    add 'Format' do
      add 'Font' do
        add item('Show Fonts', action: 'orderFrontFontPanel:', keyEquivalent: 't')
        add item('Bold', action: 'addFontTrait:', keyEquivalent: 'b')
        add item('Italic', action: 'addFontTrait:', keyEquivalent: 'i')
        add item('Underline', action: 'underline:', keyEquivalent: 'u')
        add NSMenuItem.separatorItem
        add item('Bigger', action: 'modifyFont:', keyEquivalent: '+')
        add item('Smaller', action: 'modifyFont:', keyEquivalent: '-')
      end

      add 'Text' do
        add item('Align Left', action: 'alignLeft:', keyEquivalent: '{')
        add item('Center', action: 'alignCenter:', keyEquivalent: '|')
        add item('Justify', action: 'alignJustified:', keyEquivalent: '')
        add item('Align Right', action: 'alignRight:', keyEquivalent: '}')
        add NSMenuItem.separatorItem
        add item('Show Ruler', action: 'toggleRuler:', keyEquivalent: '')
        item = add item('Copy Ruler', action: 'copyRuler:', keyEquivalent: 'c')
        item.keyEquivalentModifierMask = NSCommandKeyMask|NSControlKeyMask
        item = add item('Paste Ruler', action: 'pasteRuler:', keyEquivalent: 'v')
        item.keyEquivalentModifierMask = NSCommandKeyMask|NSControlKeyMask
      end
    end

    add 'View' do
      item = add item('Show Toolbar', action: 'toggleToolbarShown:', keyEquivalent: 't')
      item.keyEquivalentModifierMask = NSCommandKeyMask|NSAlternateKeyMask
      add item('Customize Toolbar…', action: 'runToolbarCustomizationPalette:', keyEquivalent: '')
    end

    NSApp.windowsMenu = add window_menu
    NSApp.helpMenu = add help_menu
  end

  private

  def addMenu(title, &b)
    item = createMenu(title, &b)
    @mainMenu.addItem item
    item
  end

  def createMenu(title, &b)
    menu = NSMenu.alloc.initWithTitle(title)
    menu.instance_eval(&b) if b
    item = NSMenuItem.alloc.initWithTitle(title, action: nil, keyEquivalent: '')
    item.submenu = menu
    item
  end
end
