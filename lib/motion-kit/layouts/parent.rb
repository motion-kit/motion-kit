module MotionKit
  # Simple class that returns data about the parent element
  # for use while setting the styles of a child element.
  class Parent

    attr_reader :element

    def initialize(element)
      @element = element
    end

    def origin
      try(:frame, :origin)
    end

    def size
      try(:frame, :size)
    end

    def x
      try(:frame, :origin, :x)
    end

    def y
      try(:frame, :origin, :y)
    end

    def width
      try(:frame, :size, :width)
    end

    def height
      try(:frame, :size, :height)
    end

    def center_x
      width / 2.0 if width
    end

    def center_y
      height / 2.0 if height
    end

    def center
      CGPointMake(center_x, center_y) if width && height
    end

  protected

    # Convenience method that takes a list of method calls and tries
    # them end-to-end, returning nil if any fail to respond to that
    # method name.
    # Very similar to ActiveSupport's `.try` method.
    def try(*method_chain)
      obj = self.element
      method_chain.each do |m|
        # We'll break out and return nil if any part of the chain
        # doesn't respond properly.
        (obj = nil) && break unless obj.respond_to?(m)
        obj = obj.send(m)
      end
      obj
    end

  end

end
