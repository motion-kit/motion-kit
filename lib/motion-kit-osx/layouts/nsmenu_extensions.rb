motion_require 'nsmenu_layout'

module MotionKit
  class NSMenuLayout < MenuLayout

    # useful when writing menus
    def app_name
      NSBundle.mainBundle.infoDictionary['CFBundleName']
    end

    def app_menu(title=nil, options={})
      title ||= app_name
      exclude = options.fetch(:exclude, [])
      create(title) do
        unless exclude.include?(:about)
          add about_item
          add separator_item
        end
        unless exclude.include?(:services)
          add services_item
          add separator_item
        end
        unless exclude.include?(:hide)
          add hide_item
          add hide_others_item
        end
        add show_all_item unless exclude.include?(:show)
        add quit_item unless exclude.include?(:quit)
      end
    end

    def separator_item
      NSMenuItem.separatorItem
    end

    def about_item(options={})
      title = options.fetch(:title, "About #{app_name}")
      key = options.fetch(:keyEquivalent, options.fetch(:key, ''))
      action = options.fetch(:action, 'orderFrontStandardAboutPanel:')
      return self.item(title, action: action, keyEquivalent: key)
    end

    def services_item(options={})
      title = options.fetch(:title, 'Services')
      key = options.fetch(:keyEquivalent, options.fetch(:key, ''))
      action = options.fetch(:action, nil)
      item = self.item(title, action: nil, keyEquivalent: key)
      NSApp.servicesMenu = services_item.submenu = NSMenu.new
      return item
    end

    def hide_item(options={})
      title = options.fetch(:title, "Hide #{app_name}")
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'h'))
      action = options.fetch(:action, 'hide:')
      return self.item(title, action: action, keyEquivalent: key)
    end

    def hide_others_item(options={})
      title = options.fetch(:title, 'Hide Others')
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'h'))
      action = options.fetch(:action, 'hideOtherApplications:')
      item = self.item(title, action: action, keyEquivalent: key)
      item.keyEquivalentModifierMask NSCommandKeyMask | NSAlternateKeyMask
      return item
    end

    def show_all_item(options={})
      title = options.fetch(:title, 'Show All')
      key = options.fetch(:keyEquivalent, options.fetch(:key, ''))
      action = options.fetch(:action, 'unhideAllApplications:')
      return self.item(title, action: action, keyEquivalent: key)
    end

    def quit_item(options={})
      title = options.fetch(:title, "Quit #{app_name}")
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'q'))
      action = options.fetch(:action, 'terminate:')
      return self.item(title, action: action, keyEquivalent: key)
    end

    def new_item(options={})
      title = 'New'
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'n'))
      action = options.fetch(:action, 'newDocument:')
      return item(title, action: action, keyEquivalent: key)
    end

    def open_item(options={})
      title = 'Open…'
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'o'))
      action = options.fetch(:action, 'openDocument:')
      return item(title, action: action, keyEquivalent: key)
    end

    def close_item(options={})
      title = 'Close'
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'w'))
      action = options.fetch(:action, 'performClose:')
      return item(title, action: action, keyEquivalent: key)
    end

    def save_item(options={})
      title = 'Save…'
      key = options.fetch(:keyEquivalent, options.fetch(:key, 's'))
      action = options.fetch(:action, 'saveDocument:')
      return item(title, action: action, keyEquivalent: key)
    end

    def revert_to_save_item(options={})
      title = 'Revert to Saved'
      key = options.fetch(:keyEquivalent, options.fetch(:key, ''))
      action = options.fetch(:action, 'revertDocumentToSaved:')
      return item(title, action: action, keyEquivalent: key)
    end

    def page_setup_item(options={})
      title = 'Page Setup…'
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'P'))
      action = options.fetch(:action, 'runPageLayout:')
      return item(title, action: action, keyEquivalent: key)
    end

    def print_item(options={})
      title = 'Print…'
      key = options.fetch(:keyEquivalent, options.fetch(:key, 'p'))
      action = options.fetch(:action, 'printDocument:')
      return item(title, action: action, keyEquivalent: key)
    end

    ##|
    ##|  These methods are meant to be called on the parent menu item, but
    ##|  there's no way to reference an NSMenu's parent *item* (only its parent
    ##|  *menu*).  So the @menu_item is stored in an ivar before the menu block
    ##|  is created, and these methods access that menu item.
    ##|

    # sets the title of the current NSMenu AND it's parent NSMenuItem
    def title(value)
      target.title = value
      @menu_item.title = value
    end

    def attributedTitle(value)
      target.title = value.to_s
      @menu_item.attributedTitle = value
    end

    def attributed_title(value)
      target.title = value.to_s
      @menu_item.attributedTitle = value
    end

    def state(value)
      @menu_item.state = value
    end

    def tag(value)
      @menu_item.tag = value
    end

    def keyEquivalentModifierMask(value)
      @menu_item.keyEquivalentModifierMask = value
    end

    def key_equivalent_modifier_mask(value)
      @menu_item.keyEquivalentModifierMask = value
    end

  end
end
