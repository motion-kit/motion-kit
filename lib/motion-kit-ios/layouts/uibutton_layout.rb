# @provides MotionKit::UIButtonLayout
# @requires MotionKit::UIViewLayout
module MotionKit
  class UIButtonLayout < UIViewLayout
    targets UIButton

    def title(value)
      target.setTitle(value, forState: UIControlStateNormal)
    end

    def image(value)
      target.setImage(value, forState: UIControlStateNormal)
    end

    def image(value)
      self.setImage(value, forState: UIControlStateNormal)
    end

  end
end
