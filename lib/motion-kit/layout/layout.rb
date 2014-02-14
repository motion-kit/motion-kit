module MotionKit
  class Layout

    # The parent view.
    def view
      layout
      @view
    end

    def root(element, element_id, &block)
      @view = :root
      @view = add(element, element_id, &block)
    end

    # Adds a view and allows for subviews or styling within the optional block.
    def add(element, element_id)
      # Initialize the element, if necessary
      element = initialize_view(element)

      # Set the name of the element
      self.element_ids[element_id] = WeakRef.new(element)

      # Add it to the current context or set as root view if calling with root
      if @view == :root
        @view = element
        @view_hierarchy ||= [ @view ]
      else
        @view ||= UIView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
        @view_hierarchy ||= [ @view ]
        self.current_view.addSubview(element)
      end

      # Make the element the new context
      if block_given?
        @view_hierarchy << element
        yield
        @view_hierarchy.pop
      end

      element
    end

    # Retrieves a view by its element id.
    def get(element_id)
      self.element_ids[element_id]
    end

    # Removes a view from its hierarchy and forgets it entirely.
    def remove(element_id)
      elem = self.element_ids[element_id]
      if elem
        elem.removeFromSuperview
        self.element_ids[element_id] = nil
      end
      nil
    end

  protected

    def element_ids
      @element_ids ||= {}
    end

    def current_view
      @view_hierarchy.last
    end

    # Initializes an instance of a view. This will need
    # to be smarter going forward as `new` isn't always
    # the designated initializer.
    def initialize_view(elem)
      elem = elem.new if elem.respond_to?(:new)
      elem
    end
 
  end
end
