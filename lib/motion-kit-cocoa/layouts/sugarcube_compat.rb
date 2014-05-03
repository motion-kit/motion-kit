# @requires MotionKit::BaseLayout
module MotionKit
  class BaseLayout

    def frame(*values)
      apply(:frame, *values)
    end

    def left(*values)
      apply(:left, *values)
    end

    def right(*values)
      apply(:right, *values)
    end

    def up(*values)
      apply(:up, *values)
    end

    def down(*values)
      apply(:down, *values)
    end

    def origin(*values)
      apply(:origin, *values)
    end

    def size(*values)
      apply(:size, *values)
    end

    def center(*values)
      apply(:center, *values)
    end

  end
end
