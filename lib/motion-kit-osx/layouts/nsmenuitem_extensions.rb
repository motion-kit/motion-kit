# @requires MotionKit::NSMenuLayout
module MotionKit
  class NSMenuLayout

    ##|
    ##|  These methods are meant to be called on the parent menu item, but
    ##|  there's no way to reference an NSMenu's parent *item* (only its parent
    ##|  *menu*).  So the @menu_item is stored in an ivar before the menu block
    ##|  is created, and these methods access that menu item.
    ##|

    # sets the title of the current NSMenu AND it's parent NSMenuItem
    def title(value)
      target.title = value
      @menu_item.title = value
    end

    def attributedTitle(value)
      target.title = value.to_s
      @menu_item.attributedTitle = value
    end

    def attributed_title(value)
      target.title = value.to_s
      @menu_item.attributedTitle = value
    end

    def state(value)
      @menu_item.state = value
    end

    def tag(value)
      @menu_item.tag = value
    end

    def keyEquivalentModifierMask(value)
      @menu_item.keyEquivalentModifierMask = value
    end

    def key_equivalent_modifier_mask(value)
      @menu_item.keyEquivalentModifierMask = value
    end

  end
end
