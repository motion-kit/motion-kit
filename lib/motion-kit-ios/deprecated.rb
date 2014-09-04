module MotionKit

  class UIViewLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  UIViewLayout is now UIViewHelpers.  Update #{subclass} to extend from UIViewHelpers.")
    end
  end

  class UIButtonLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  UIButtonLayout is now UIButtonHelpers.  Update #{subclass} to extend from UIButtonHelpers.")
    end
  end

  class CALayerLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  CALayerLayout is now CALayerHelpers.  Update #{subclass} to extend from CALayerHelpers.")
    end
  end

  class CAGradientLayerLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  CAGradientLayerLayout is now CAGradientLayerHelpers.  Update #{subclass} to extend from CAGradientLayerHelpers.")
    end
  end

end
