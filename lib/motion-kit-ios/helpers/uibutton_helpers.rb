# @provides MotionKit::UIButtonHelpers
# @requires MotionKit::UIViewHelpers
module MotionKit
  class UIButtonHelpers < UIViewHelpers
    targets UIButton

    def title(value)
      title(value, state: UIControlStateNormal)
    end

    def title(value, state: state)
      if value.is_a?(NSAttributedString)
        target.setAttributedTitle(value, forState: state)
      else
        target.setTitle(value, forState: state)
      end
    end

    def title_color(value)
      title_color(value, state: UIControlStateNormal)
    end

    def title_color(value, state: state)
      target.setTitleColor(value, forState: state)
    end

    def title_shadow_color(value)
      title_shadow_color(value, state: UIControlStateNormal)
    end

    def title_shadow_color(value, state: state)
      target.setTitleShadowColor(value, forState: state)
    end

    def title_font(font)
      target.titleLabel.setFont(font)
    end

    def background_image(value)
      background_image(value, state: UIControlStateNormal)
    end

    def background_image(value, state: state)
      target.setBackgroundImage(value, forState: state)
    end

    def image(value)
      image(value, state: UIControlStateNormal)
    end

    def image(value, state: state)
      target.setImage(value, forState: state)
    end

  end
end
