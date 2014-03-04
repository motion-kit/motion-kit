motion_require 'uiview_layout'

module MotionKit
  class UIButtonLayout < UIViewLayout
    targets UIButton

    def title(value)
      self.setTitle(value, forState: UIControlStateNormal)
    end

  end
end
