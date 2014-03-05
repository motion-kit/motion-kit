motion_require 'nsmenu_layout'

module MotionKit
  class NSMenuLayout

    # useful when writing menus
    def app_name
      NSBundle.mainBundle.infoDictionary['CFBundleName']
    end

    def _menu_title_and_options(title, options, default_title=nil, default_options={})
      if title.is_a?(NSDictionary)
        options = title
        title = options[:title]
      end
      title ||= default_title
      return title, default_options.merge(options)
    end

    def app_menu(title=nil, options={})
      title, options = _menu_title_and_options(title, options, app_name)

      exclude = Array(options.fetch(:exclude, []))
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

    def file_menu(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'File')

      exclude = Array(options.fetch(:exclude, []))
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

    def window_menu(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Window')

      exclude = Array(options.fetch(:exclude, []))
      create(title) do
        add minimize_item unless exclude.include?(:minimize)
        add zoom_item unless exclude.include?(:zoom)
        add separator_item unless [:minimize, :zoom].all? { |menu_name| exclude.include?(menu_name) }

        add bring_all_to_front_item unless exclude.include?(:bring_all_to_front)
      end
    end

    def help_menu(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Help')

      exclude = Array(options.fetch(:exclude, []))
      create(title) do
        add help_item
      end
    end

    def separator_item
      NSMenuItem.separatorItem
    end

    def about_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, "About #{app_name}", { action: 'orderFrontStandardAboutPanel:' })
      return self.item(title, options)
    end

    def preferences_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Preferences', { key: ',', action: 'openPreferences:' })
      return self.item(title, options)
    end

    def services_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Services')
      return self.item(title, options)
    end

    def hide_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, "Hide #{app_name}", { key: 'h', action: 'hide:' })
      return self.item(title, options)
    end

    def hide_others_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Hide Others', { key: 'h', action: 'hideOtherApplications:', mask: NSCommandKeyMask | NSAlternateKeyMask })
      return self.item(title, options)
    end

    def show_all_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Show All', { action: 'unhideAllApplications:' })
      return self.item(title, options)
    end

    def quit_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, "Quit #{app_name}", { key: 'q', action: 'terminate:' })
      return self.item(title, options)
    end

    def new_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'New', { key: 'n', action: 'newDocument:' })
      return self.item(title, options)
    end

    def open_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Open…', { key: 'o', action: 'openDocument:' })
      return self.item(title, options)
    end

    def close_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Close', { key: 'w', action: 'performClose:' })
      return self.item(title, options)
    end

    def save_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Save…', { key: 's', action: 'saveDocument:' })
      return self.item(title, options)
    end

    def save_as_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Save as…', { key: 'S', action: 'saveDocumentAs:' })
      return self.item(title, options)
    end

    def revert_to_save_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Revert to Saved', { action: 'revertDocumentToSaved:' })
      return self.item(title, options)
    end

    def page_setup_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Page Setup…', { key: 'P', action: 'runPageLayout:' })
      return self.item(title, options)
    end

    def print_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Print…', { key: 'p', action: 'printDocument:' })
      return self.item(title, options)
    end

    def minimize_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Minimize', { key: 'm', action: 'performMiniaturize:' })
      return self.item(title, options)
    end

    def zoom_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Zoom', { action: 'performMiniaturize:' })
      return self.item(title, options)
    end

    def bring_all_to_front_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, 'Bring All To Front', { action: 'arrangeInFront:' })
      return self.item(title, options)
    end

    def help_item(title=nil, options={})
      title, options = _menu_title_and_options(title, options, "#{app_name} Help", { key: '?', action: 'showHelp:' })
      return self.item("#{app_name} Help", options)
    end

  end
end
