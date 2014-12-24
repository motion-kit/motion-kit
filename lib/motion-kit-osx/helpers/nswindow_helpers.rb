# @provides MotionKit::WindowLayout
# @provides MotionKit::NSWindowHelpers
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

  end

  class NSWindowHelpers < WindowLayout
    targets NSWindow
  end

end
