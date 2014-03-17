motion_require 'nsview_layout'

module MotionKit
  class NSTableColumnLayout < BaseLayout
    targets NSTableColumn

    def title(value)
      target.headerCell.stringValue = value
    end

  end
end
