# @requires MotionKit::BaseLayout
module MotionKit
  class BaseLayout

    # This method is used to check the orientation.  On an ipad, this method
    # returns true for :portrait if the device is "upside down", but it returns
    # false in the same situation on an iphone.
    def orientation?(value)
      if target.is_a?(UIView) && target.nextResponder && target.nextResponder.is_a?(UIViewController)
        interface_orientation = target.nextResponder.interfaceOrientation
      else
        interface_orientation = UIApplication.sharedApplication.statusBarOrientation
      end

      return case value
      when :portrait
        if ipad?
          interface_orientation == UIInterfaceOrientationPortrait || interface_orientation == UIInterfaceOrientationPortraitUpsideDown
        else
          interface_orientation == UIInterfaceOrientationPortrait
        end
      when :upright, UIInterfaceOrientationPortrait
        interface_orientation == UIInterfaceOrientationPortrait
      when :landscape
        interface_orientation == UIInterfaceOrientationLandscapeLeft || interface_orientation == UIInterfaceOrientationLandscapeRight
      when :landscape_left, UIInterfaceOrientationLandscapeLeft
        interface_orientation == UIInterfaceOrientationLandscapeLeft
      when :landscape_right, UIInterfaceOrientationLandscapeRight
        interface_orientation == UIInterfaceOrientationLandscapeRight
      when :upside_down, UIInterfaceOrientationPortraitUpsideDown
        interface_orientation == UIInterfaceOrientationPortraitUpsideDown
      end
    end

    [:portrait, :upright, :upside_down, :landscape, :landscape_left, :landscape_right].each do |orientation|
      define_method("#{orientation}?") do
        return orientation?(orientation)
      end
      define_method(orientation) do |&block|
        orientation_block(orientation, block)
      end
    end

    def orientation_block(orientation, block)
      block = block.weak!
      always do
        if orientation?(orientation)
          block.call
        end
      end
    end

  end
end