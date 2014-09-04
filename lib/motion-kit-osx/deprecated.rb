module MotionKit

  class NSWindowLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  NSWindowLayout is now NSWindowHelpers.  Update #{subclass} to extend from NSWindowHelpers.")
    end
  end

  class NSViewLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  NSViewLayout is now NSViewHelpers.  Update #{subclass} to extend from NSViewHelpers.")
    end
  end

  class NSTableViewLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  NSTableViewLayout is now NSTableViewHelpers.  Update #{subclass} to extend from NSTableViewHelpers.")
    end
  end

  class NSTableColumnLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  NSTableColumnLayout is now NSTableColumnHelpers.  Update #{subclass} to extend from NSTableColumnHelpers.")
    end
  end

  class NSMenuLayout
    def self.inherited(subclass)
      NSLog("Sorry!  MotionKit changed.  NSMenuLayout is now NSMenuHelpers.  Update #{subclass} to extend from NSMenuHelpers.")
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
