# @provides MotionKit::NSTableColumnHelpers
# @requires MotionKit::BaseLayout
module MotionKit
  class NSTableColumnHelpers < BaseLayout
    targets NSTableColumn

    def title(value)
      target.headerCell.stringValue = value
    end

  end
end
