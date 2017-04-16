# @provides module:MotionKit::UIToolbarAppearance
module MotionKit
  module UIToolbarAppearance

    def bar_tint_color(color)
      appearance.barTintColor = color
    end

    def background_image(image, toolbar_position: top_or_bottom, bar_metrics: bar_metrics)
      appearance.setBackgroundImage image, forToolbarPosition:top_or_bottom , barMetrics:bar_metrics
    end

    def shadow_image(image, toolbar_position: top_or_bottom)
      appearance.setShadowImage image, forToolbarPosition:top_or_bottom
    end

  end
end
