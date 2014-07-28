# @provides MotionKit::Layout
# @provides MotionKit::NSViewLayout
# @requires MotionKit::TreeLayout
module MotionKit
  class Layout < TreeLayout

    # platform specific default root view
    def default_root
      # child Layout classes will return *their* NSView subclass from self.targets
      view_class = self.class.targets || MotionKit.default_view_class
      view_class.alloc.initWithFrame([[0, 0], [0, 0]])
    end

    def add_child(subview)
      target.addSubview(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

  end

  class NSViewLayout < Layout
    targets NSView
  end

end
