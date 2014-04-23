motion_require 'uiview_layout'

module MotionKit
  class Layout

    def iphone?
      UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone
    end

    def iphone(&block)
      block.call if block && iphone?
    end

    def iphone4?
      iphone? && UIScreen.mainScreen.bounds.size.width == 320 && UIScreen.mainScreen.bounds.size.height == 568
    end

    def iphone4(&block)
      block.call if block && iphone4?
    end

    def iphone35?
      iphone? && UIScreen.mainScreen.bounds.size.width == 320 && UIScreen.mainScreen.bounds.size.height == 480
    end

    def iphone35(&block)
      block.call if block && iphone35?
    end

    def ipad(&block)
      block.call if block && ipad?
    end

    def ipad?
      UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
    end

    def retina?
      UIScreen.mainScreen.respond_to?(:scale) && UIScreen.mainScreen.scale == 2
    end

    [:iphone, :iphone4, :iphone35, :ipad, :retina].each do |method_name|
      define_method(method_name) do |&block|
        block.call if self.send("#{method_name}?")
      end
    end

  end
end
