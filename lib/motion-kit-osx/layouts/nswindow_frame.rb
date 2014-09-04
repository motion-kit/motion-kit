# @requires MotionKit::NSWindowHelpers
module MotionKit
  class NSWindowHelpers

    def frame(value, autosave_name=nil)
      retval = target.setFrame(value, display: true)
      if autosave_name
        target.setFrameAutosaveName(autosave_name)
      end
      return retval
    end

  end
end
