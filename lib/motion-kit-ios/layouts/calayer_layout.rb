module MotionKit
  class CALayerLayout < ViewLayout
    targets CALayer

    # platform specific default root view
    def default_root
      CALayer.layer
    end

    def add_child(subview)
      v.addSublayer(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperlayer
    end

  end

end
