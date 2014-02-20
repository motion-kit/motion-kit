module MotionKit
  class Layout

    # This method is used to check the orientation.  On an ipad, this method
    # returns true for :portrait if the device is "upside down", but it returns
    # false in the same situation on an iphone.
    def orientation?(value)
      if ipad? && value == :portrait
        return true if orientation?(:upside_down)
      end

      case value
      when :portrait, :upright, UIInterfaceOrientationPortrait
        UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationPortrait
      when :landscape, :landscape_left, UIInterfaceOrientationLandscapeLeft
        UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeLeft
      when :landscape, :landscape_right, UIInterfaceOrientationLandscapeRight
        UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeRight
      when :upside_down, UIInterfaceOrientationPortraitUpsideDown
        UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown
      end
    end

    [:portrait, :upright, :upside_down, :landscape, :landscape_left, :landscape_right].each do |orientation|
      define_method("#{orientation}?") do
        return orientation?(orientation)
      end
      define_method(orientation) do |&block|
        if orientation?(orientation)
          yield
        end
      end
    end

    def iphone?
      UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone
    end

    def ipad?
      UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
    end

    def retina?
      UIScreen.mainScreen.respond_to?(:scale) && UIScreen.mainScreen.scale == 2
    end

  end
end