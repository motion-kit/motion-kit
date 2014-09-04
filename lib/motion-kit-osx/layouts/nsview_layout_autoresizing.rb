# @requires MotionKit::NSViewHelpers
module MotionKit
  class NSViewHelpers

    def autoresizing_mask(*values)
      value = 0
      values.each do |mask|
        case mask
        when :flexible_left
          value |= NSViewMinXMargin
        when :flexible_width
          value |= NSViewWidthSizable
        when :flexible_right
          value |= NSViewMaxXMargin
        when :flexible_top
          value |= NSViewMaxYMargin
        when :flexible_height
          value |= NSViewHeightSizable
        when :flexible_bottom
          value |= NSViewMinYMargin

        when :rigid_left
          value ^= NSViewMinXMargin
        when :rigid_width
          value ^= NSViewWidthSizable
        when :rigid_right
          value ^= NSViewMaxXMargin
        when :rigid_top
          value ^= NSViewMaxYMargin
        when :rigid_height
          value ^= NSViewHeightSizable
        when :rigid_bottom
          value ^= NSViewMinYMargin

        when :fill
          value |= NSViewWidthSizable | NSViewHeightSizable
        when :fill_top
          value |= NSViewWidthSizable | NSViewMinYMargin
        when :fill_bottom
          value |= NSViewWidthSizable | NSViewMaxYMargin
        when :fill_left
          value |= NSViewHeightSizable | NSViewMaxXMargin
        when :fill_right
          value |= NSViewHeightSizable | NSViewMinXMargin

        when :pin_to_top_left
          value |= NSViewMaxXMargin | NSViewMinYMargin
        when :pin_to_top
          value |= NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin
        when :pin_to_top_right
          value |= NSViewMinXMargin | NSViewMinYMargin
        when :pin_to_left
          value |= NSViewMaxYMargin | NSViewMinYMargin | NSViewMaxXMargin
        when :pin_to_center, :pin_to_middle
          value |= NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin | NSViewMaxXMargin
        when :pin_to_right
          value |= NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin
        when :pin_to_bottom_left
          value |= NSViewMaxXMargin | NSViewMaxYMargin
        when :pin_to_bottom
          value |= NSViewMinXMargin | NSViewMaxXMargin | NSViewMaxYMargin
        when :pin_to_bottom_right
          value |= NSViewMinXMargin | NSViewMaxYMargin
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
