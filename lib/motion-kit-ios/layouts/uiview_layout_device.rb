motion_require 'uiview_layout'

module MotionKit
  class UIViewLayout

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