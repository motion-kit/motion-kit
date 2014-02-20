module MotionKit
  class NoContextError < Exception
  end
  class ContextConflictError < Exception
  end
  class InvalidRootError < Exception
  end
end
::MK = MotionKit unless defined?(::MK)
