# @provides MotionKit::UIButtonLayout
# @requires MotionKit::UIViewLayout
module MotionKit
  class UIButtonLayout < UIViewLayout
    targets UIButton

    def title(value)
      if value.is_a?(NSAttributedString)
        target.setAttributedTitle(value, forState: UIControlStateNormal)
      else
        target.setTitle(value, forState: UIControlStateNormal)
      end
    end

    def title_color(value)
      target.setTitleColor(value, forState: UIControlStateNormal)
    end

    def title_shadow_color(value)
      target.setTitleShadowColor(value, forState: UIControlStateNormal)
    end

    def background_image(value)
      target.setBackgroundImage(value, forState: UIControlStateNormal)
    end

    def image(value)
      target.setImage(value, forState: UIControlStateNormal)
    end

  end
end
