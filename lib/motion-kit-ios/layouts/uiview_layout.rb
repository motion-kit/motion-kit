motion_require '../../motion-kit/layouts/layout'

module MotionKit
  class UIViewLayout < ViewLayout
    targets UIView

    # platform specific default root view
    def default_root
      # child Layout classes will return *their* UIView subclass from self.targets
      self.class.targets.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    end

    def add_child(subview)
      v.addSubview(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

  end

  # this is the default container layout, which is different for each platform.
  class Layout < UIViewLayout
  end

end
