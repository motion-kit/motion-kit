motion_require '../../motion-kit/layouts/layout'

module MotionKit
  class WindowLayout < ViewLayout

    # A more sensible name for the window that is created.
    def window
      self.view
    end

    # platform specific default root view
    def default_root
      # child WindowLayout classes can return *their* NSView subclass from self.nsview_class
      view_class = self.class.targets || NSWindow
      view_class.alloc.initWithContentRect([[0, 0], [0, 0]],
        styleMask: NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask,
        backing: NSBackingStoreBuffered,
        defer: false)
    end

    def add_child(subview)
      target.contentView.addSubview(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

    # NSWindow doesn't have immediate children; restyle its contentView.
    def reapply!(window=nil)
      window ||= self.window
      call_style_method(window, window.motion_kit_id) if window.motion_kit_id
      super(window.contentView)
    end

    def get(element_id)
      if self.window.motion_kit_id == element_id
        return self.window
      else
        self.get(element_id, in: self.window.contentView)
      end
    end

    def last(element_id)
      if last = self.last(element_id, in: self.window.contentView)
        last
      elsif self.window.motion_kit_id == element_id
        self.window
      else
        nil
      end
    end

    def all(element_id)
      found = self.all(element_id, in: self.window.contentView)
      if self.window.motion_kit_id == element_id
        found << self.window
      end
      return found
    end

    def nth(element_id, index)
      self.all(element_id, in: self.window.contentView)[index]
    end

    def remove(element_id)
      self.remove(element_id, from: self.window.contentView)
    end

  end

  class NSWindowLayout < WindowLayout
    targets NSWindow
  end

end
