# @provides MotionKit::Layout
# @provides MotionKit::UIViewLayout
# @requires MotionKit::TreeLayout
module MotionKit
  class Layout < TreeLayout

    # platform specific default root view
    def default_root
      # child Layout classes will return *their* UIView subclass from self.targets
      view_class = self.class.targets || MotionKit.default_view_class
      view_class.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    end

    def add_child(subview)
      target.addSubview(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

  end

  class UIViewLayout < Layout
    targets UIView
  end

end
