# @provides module:MotionKit::UITableViewAppearance
module MotionKit
  module UITableViewAppearance

    def separator_inset(inset)
      appearance.separatorInset = inset
    end

    def section_index_color(color)
      appearance.sectionIndexColor = color
    end

    def section_index_background_color(color)
      appearance.sectionIndexBackgroundColor = color
    end

    def section_index_tracking_background_color(color)
      appearance.sectionIndexTrackingBackgroundColor = color
    end

  end
end
