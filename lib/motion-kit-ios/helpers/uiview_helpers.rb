# @provides MotionKit::Layout
# @provides MotionKit::UIViewHelpers
# @requires MotionKit::TreeLayout
module MotionKit
  class Layout < TreeLayout

    # platform specific default root view
    def default_root
      # child Layout classes will return *their* UIView subclass from self.targets
      view_class = self.class.targets || MotionKit.default_view_class
      view_class.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    end

    def add_child(subview, options={})
      if (sibling = options[:behind])
        target.insertSubview(subview, belowSubview: sibling)
      elsif (sibling = options[:in_front_of])
        target.insertSubview(subview, aboveSubview: sibling)
      elsif (z_index = options[:z_index])
        target.insertSubview(subview, atIndex: z_index)
      else
        target.addSubview(subview)
      end
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

  end

  class UIViewHelpers < Layout
    targets UIView
  end

end
