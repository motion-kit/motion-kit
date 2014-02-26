motion_require '../../motion-kit/layouts/layout'

module MotionKit
  class NSViewLayout < ViewLayout
    targets NSView

    # platform specific default root view
    def default_root
      # child Layout classes will return *their* NSView subclass from self.targets
      self.class.targets.alloc.initWithFrame([[0, 0], [100, 100]])
    end

    def add_child(subview)
      v.addSubview(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

  end

  # this is the default container layout, which is different for each platform.
  class Layout < NSViewLayout
  end

end
