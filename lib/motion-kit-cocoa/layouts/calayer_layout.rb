# @provides MotionKit::CALayerLayout
# @requires MotionKit::TreeLayout
module MotionKit
  class CALayerLayout < TreeLayout
    targets CALayer

    # platform specific default root view
    def default_root
      self.class.targets.layer
    end

    def add_child(subview)
      target.addSublayer(subview)
    end

    def remove_child(subview)
      subview.removeFromSuperlayer
    end

    # a more appropriate name for the root layer
    def layer
      self.view
    end

  end

end
