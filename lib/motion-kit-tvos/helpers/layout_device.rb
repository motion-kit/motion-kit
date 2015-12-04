# @requires MotionKit::BaseLayout
module MotionKit
  class BaseLayout

    def tv?
      UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomTV
    end

    def iphone?
      UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone
    end

    def iphone4?
      iphone? && UIScreen.mainScreen.bounds.size.width == 320 && UIScreen.mainScreen.bounds.size.height == 568
    end

    def iphone35?
      iphone? && UIScreen.mainScreen.bounds.size.width == 320 && UIScreen.mainScreen.bounds.size.height == 480
    end

    def ipad?
      UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
    end

    def retina?
      UIScreen.mainScreen.respond_to?(:scale) && UIScreen.mainScreen.scale == 2
    end

    [:tv, :iphone, :iphone4, :iphone35, :ipad, :retina].each do |method_name|
      define_method(method_name) do |&block|
        block.call if self.send("#{method_name}?")
      end
    end

  end
end
