motion_require 'uiview_layout'

module MotionKit
  class UIButtonLayout < UIViewLayout
    targets UIButton

    def add(thingy, element_id=nil, &block)
      super
    end

    def title(value)
      self.setTitle(value, forState: UIControlStateNormal)
    end

  end
end
