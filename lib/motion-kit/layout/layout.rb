module MotionKit
  class Layout

    def initialize
      @view_hierarchy = []
    end

    # The parent view.
    def view
      @view ||= begin
        layout
        # Since we can't rely on the app developers to not return something
        # screwy from their layout method, we'll return @view here.
        @view
      end
    end

    def root(element, element_id=nil, &block)
      if @view
        raise "Already created the root view"
      end

      # we need to assign the block
      @view = initialize_view(element)
      @view_hierarchy << @view
      create(@view, element_id, &block)

      return @view
    end

    def default_root
      UIView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    end

    def create(element, element_id=nil, &block)
      # Initialize the element, if necessary
      element = initialize_view(element)

      # Set the name of the element
      if element_id
        self.element_ids[element_id] << element
      end

      # Make the element the new context
      if block_given?
        @parent = @view_hierarchy.last
        @view_hierarchy << element
        yield
        @view_hierarchy.pop
        @parent = @view_hierarchy.last
      end

      element
    end

    # Adds a view and allows for subviews or styling within the optional block.
    def add(element, element_id=nil, &block)
      # setup a default context, if needed
      if @view_hierarchy.empty?
        root(default_root)
      end

      element = create(element, element_id, &block)
      self.current_view.addSubview(element)

      element
    end

    # Retrieves a view by its element id.
    def get(element_id)
      self.view
      self.element_ids[element_id].last
    end
    alias last get

    def all(element_id)
      self.view
      self.element_ids[element_id]
    end

    def first(element_id)
      self.view
      self.element_ids[element_id].first
    end

    def nth(element_id, n)
      self.view
      self.element_ids[element_id][n]
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
      @element_ids ||= Hash.new &lambda { |hash, key| hash[key] = [] }
    end

    def current_view
      @view_hierarchy.last
    end

    # Initializes an instance of a view. This will need
    # to be smarter going forward as `new` isn't always
    # the designated initializer.
    def initialize_view(elem)
      elem = elem.new if elem.is_a?(Class)
      elem
    end

  end
end
