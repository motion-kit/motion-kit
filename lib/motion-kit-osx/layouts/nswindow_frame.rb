motion_require 'nswindow_layout'

module MotionKit
  class NSWindowLayout

    def frame(value)
      target.setFrame(value, display: true)
    end

  end
end
