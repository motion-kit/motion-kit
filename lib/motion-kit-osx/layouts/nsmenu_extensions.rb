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
        unless exclude.include?(:prefs)
          add preferences_item
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

    def file_menu(title='File', options={})
      exclude = options.fetch(:exclude, [])
      create(title) do
        add new_item unless exclude.include?(:new)
        add open_item unless exclude.include?(:open)
        add separator_item unless [:new, :open].all? { |menu_name| exclude.include?(menu_name) }

        add close_item unless exclude.include?(:close)
        add save_item unless exclude.include?(:save)
        add revert_to_save_item unless exclude.include?(:revert)
        add separator_item unless [:close, :save, :revert].all? { |menu_name| exclude.include?(menu_name) }

        add page_setup_item unless exclude.include?(:page_setup)
        add print_item unless exclude.include?(:print)
      end
    end

    def window_menu(title='Window', options={})
      exclude = options.fetch(:exclude, [])
      create(title) do
        add minimize_item unless exclude.include?(:minimize)
        add zoom_item unless exclude.include?(:zoom)
        add separator_item unless [:minimize, :zoom].all? { |menu_name| exclude.include?(menu_name) }

        add bring_all_to_front_item unless exclude.include?(:bring_all_to_front)
      end
    end

    def help_menu(title='Help', options={})
      exclude = options.fetch(:exclude, [])
      create(title) do
        add help_item
      end
    end

    def separator_item
      NSMenuItem.separatorItem
    end

    def about_item(title=nil, options={})
      title ||= "About #{app_name}"
      options = { action: 'orderFrontStandardAboutPanel:' }.merge(options)
      return self.item(title, options)
    end

    def preferences_item(title='Preferences', options={})
      options = { key: ',', action: 'openPreferences:' }.merge(options)
      return self.item(title, options)
    end

    def services_item(title='Services', options={})
      return self.item(title, options)
    end

    def hide_item(title=nil, options={})
      title ||= "Hide #{app_name}"
      options = { key: 'h', action: 'hide:' }.merge(options)
      return self.item(title, options)
    end

    def hide_others_item(title='Hide Others', options={})
      options = { key: 'h', action: 'hideOtherApplications:', mask: NSCommandKeyMask | NSAlternateKeyMask }.merge(options)
      return self.item(title, options)
    end

    def show_all_item(title='Show All', options={})
      options = { action: 'unhideAllApplications:' }.merge(options)
      return self.item(title, options)
    end

    def quit_item(title=nil, options={})
      title ||= "Quit #{app_name}"
      options = { key: 'q', action: 'terminate:' }.merge(options)
      return self.item(title, options)
    end

    def new_item(title='New', options={})
      options = { key: 'n', action: 'newDocument:' }.merge(options)
      return self.item(title, options)
    end

    def open_item(title='Open…', options={})
      options = { key: 'o', action: 'openDocument:' }.merge(options)
      return self.item(title, options)
    end

    def close_item(title='Close', options={})
      options = { key: 'w', action: 'performClose:' }.merge(options)
      return self.item(title, options)
    end

    def save_item(title='Save…', options={})
      options = { key: 's', action: 'saveDocument:' }.merge(options)
      return self.item(title, options)
    end

    def save_as_item(title='Save as…', options={})
      options = { key: 'S', action: 'saveDocumentAs:' }.merge(options)
      return self.item(title, options)
    end

    def revert_to_save_item(title='Revert to Saved', options={})
      options = { action: 'revertDocumentToSaved:' }.merge(options)
      return self.item(title, options)
    end

    def page_setup_item(title='Page Setup…', options={})
      options = { key: 'P', action: 'runPageLayout:' }.merge(options)
      return self.item(title, options)
    end

    def print_item(title='Print…', options={})
      options = { key: 'p', action: 'printDocument:' }.merge(options)
      return self.item(title, options)
    end

    def minimize_item(title='Minimize', options={})
      options = { key: 'm', action: 'performMiniaturize:' }.merge(options)
      return self.item(title, options)
    end

    def zoom_item(title='Zoom', options={})
      options = { action: 'performMiniaturize:' }.merge(options)
      return self.item(title, options)
    end

    def bring_all_to_front_item(title='Bring All To Front', options={})
      options = { action: 'arrangeInFront:' }.merge(options)
      return self.item(title, options)
    end

    def help_item(title=nil, options={})
      title ||= "#{app_name} Help"
      options = { key: '?', action: 'showHelp:' }.merge(options)
      return self.item("#{app_name} Help", options)
    end

  end
end
