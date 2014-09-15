# @requires MotionKit::UIViewHelpers
module MotionKit
  class UIViewHelpers

    def autoresizing_mask(*values)
      value = 0
      values.each do |mask|
        case mask
        when :flexible_left
          value |= UIViewAutoresizingFlexibleLeftMargin
        when :flexible_width
          value |= UIViewAutoresizingFlexibleWidth
        when :flexible_right
          value |= UIViewAutoresizingFlexibleRightMargin
        when :flexible_top
          value |= UIViewAutoresizingFlexibleTopMargin
        when :flexible_height
          value |= UIViewAutoresizingFlexibleHeight
        when :flexible_bottom
          value |= UIViewAutoresizingFlexibleBottomMargin

        when :rigid_left
          value ^= UIViewAutoresizingFlexibleLeftMargin
        when :rigid_width
          value ^= UIViewAutoresizingFlexibleWidth
        when :rigid_right
          value ^= UIViewAutoresizingFlexibleRightMargin
        when :rigid_top
          value ^= UIViewAutoresizingFlexibleTopMargin
        when :rigid_height
          value ^= UIViewAutoresizingFlexibleHeight
        when :rigid_bottom
          value ^= UIViewAutoresizingFlexibleBottomMargin

        when :fill
          value |= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
        when :fill_top
          value |= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin
        when :fill_bottom
          value |= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
        when :fill_left
          value |= UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin
        when :fill_right
          value |= UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin

        when :pin_to_top_left
          value |= UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin
        when :pin_to_top
          value |= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin
        when :pin_to_top_right
          value |= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin
        when :pin_to_left
          value |= UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin
        when :pin_to_center, :pin_to_middle
          value |= UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
        when :pin_to_right
          value |= UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin
        when :pin_to_bottom_left
          value |= UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
        when :pin_to_bottom
          value |= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
        when :pin_to_bottom_right
          value |= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin
        else
          value |= mask
        end
      end

      target.autoresizingMask = value
      value
    end
    alias autoresizingMask autoresizing_mask

  end
end
