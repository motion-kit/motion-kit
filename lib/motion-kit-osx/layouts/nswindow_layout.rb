# @provides MotionKit::WindowLayout
# @provides MotionKit::NSWindowLayout
# @requires MotionKit::TreeLayout
module MotionKit
  class WindowLayout < TreeLayout

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
      context(window) do
        super(window.contentView)
      end
    end

    def get(element_id)
      if self.window.motion_kit_id == element_id
        return self.window
      elsif self._root == self.window
        self.get(element_id, in: self.window.contentView)
      else
        super
      end
    end

    def last(element_id)
      if self._root == self.window && last = self.last(element_id, in: self.window.contentView)
        last
      elsif self.window.motion_kit_id == element_id
        self.window
      else
        super
      end
    end

    def all(element_id)
      if self._root == self.window
        found = self.all(element_id, in: self.window.contentView)
        if self.window.motion_kit_id == element_id
          found << self.window
        end
        return found
      else
        super
      end
    end

    def remove(element_id)
      if self._root == self.window
        self.remove(element_id, from: self.window.contentView)
      else
        super
      end
    end

  end

  class NSWindowLayout < WindowLayout
    targets NSWindow
  end

end
