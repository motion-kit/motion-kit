motion_require '../../motion-kit/layouts/layout'

module MotionKit
  class MenuLayout < ViewLayout

    # A more sensible name for the menu that is created.
    def menu
      self.view
    end

    # platform specific default root view
    def default_root
      # child WindowLayout classes can return *their* NSView subclass from self.nsview_class
      menu_class = self.class.targets || NSMenu
      menu_class.alloc.init
    end

    def add_child(submenu)
      target.addItem(submenu)
    end

    def remove_child(submenu)
      target.removeItem(submenu)
    end

    # override root to allow a menu title for the top level menu
    def root(element, element_id=nil, &block)
      if element && element.is_a?(NSString)
        element = NSMenu.alloc.initWithTitle(element)
      end
      super(element, element_id, &block)
    end

    # override 'add'; menus are just a horse of a different color.
    def add(title_or_item, element_id=nil, options={}, &block)
      unless @context
        create_default_root_context
      end

      if element_id.is_a?(NSDictionary)
        options = element_id
        element_id = nil
      end

      if title_or_item.is_a?(NSMenuItem)
        item = title_or_item
        menu = nil
        retval = item
      elsif title_or_item.is_a?(NSMenu)
        menu = title_or_item
        item = self.item(menu.title, options)
        item.submenu = menu
        retval = menu
      else
        title = title_or_item
        item = self.item(title, options)

        if block
          menu = create(title)
          item.submenu = menu
          retval = menu
        else
          retval = item
        end
      end

      self.apply(:add_child, item)

      if menu && block
        menuitem_was = @menu_item
        @menu_item = item
        context(menu, &block)
        @menu_item = menuitem_was
      end

      if element_id
        create(retval, element_id)
      end

      return retval
    end

    def create(title_or_item, element_id=nil, &block)
      if title_or_item.is_a?(NSMenu) || title_or_item.is_a?(NSMenuItem)
        item = title_or_item
      else
        item = NSMenu.alloc.initWithTitle(title_or_item)
      end

      return super(item, element_id, &block)
    end

    def item(title, options={})
      action = options.fetch(:action, nil)
      key = options.fetch(:keyEquivalent, options.fetch(:key, ''))
      mask = options.fetch(:keyEquivalentModifierMask, options.fetch(:mask, nil))
      item = NSMenuItem.alloc.initWithTitle(title, action: action, keyEquivalent: key)
      unless mask.nil?
        item.keyEquivalentModifierMask = mask
      end
      return item
    end

  end

  class NSMenuLayout < MenuLayout
    targets NSMenu
  end
end
