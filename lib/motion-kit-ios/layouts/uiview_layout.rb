# @provides MotionKit::Layout
# @provides MotionKit::UIViewLayout
# @requires MotionKit::ViewLayout
module MotionKit
  class Layout < ViewLayout

    # platform specific default root view
    def default_root
      # child Layout classes will return *their* UIView subclass from self.targets
      view_class = self.class.targets || MotionKit.default_view_class
      view_class.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    end

    def container
      UIView
    end

    def add_child(subview)
      target.addSubview(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

    # UIViews AND CALayers are updated
    def reapply!(root=nil)
      if root.is_a?(CALayer)
        @layout_state = :reapply
        MotionKit.find_all_layers(root) do |layer|
          call_style_method(layer, layer.motion_kit_id) if layer.motion_kit_id
        end
        @layout_state = :initial
      else
        root ||= self.view
        reapply!(root.layer)
        super(root)
      end

      return self
    end

  end

  class UIViewLayout < Layout
    targets UIView
  end

end
