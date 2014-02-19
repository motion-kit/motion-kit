module MotionKit
  class Layout
    include Styleable

    def initialize
      @view_stack = []
    end

    # The parent view.  This method builds the layout and returns the root view.
    def view
      @view ||= begin
        layout
        # Since we can't rely on the app developers to not return something
        # screwy from their layout method, we'll return @view here.
        @view
      end
    end

    # Assign a view to act as the 'root' view for this layout.  This method can
    # only be called once, and must be called before `add` is called for the
    # first time (otherwise `add` will create a default root view).
    def root(element, element_id=nil, &block)
      if @view
        raise "Already created the root view"
      end

      # before we run the block, the root @view must be assigned, and added to
      # the view_stack
      @view = initialize_view(element)
      @view_stack << @view
      create(@view, element_id, &block)

      return @view
    end

    # platform specific default root view
    def default_root
      UIView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    end

    # instantiates a view, possibly running a 'layout block' to add child views.
    def create(element, element_id=nil, &block)
      # Initialize the element, if necessary
      element = initialize_view(element)

      # Set the name of the element
      if element_id
        self.element_ids[element_id] << element

        style_method = "#{element_id}_style"
        if self.respond_to?(style_method)
          self.context(element) do
            self.send(style_method)
          end
        end
      end

      # Make the element the new context
      if block
        @parent = @view_stack.last
        @view_stack << element
        context(element, &block)
        @view_stack.pop
        @parent = @view_stack.last
      end

      element
    end

    # Delegates to `create` to instantiate a view and run a layout block, and
    # adds the view to the current view on the view stack.  If no view exists on
    # the stack, a default root view is created.
    def add(element, element_id=nil, &block)
      if @view_stack.empty?
        root(default_root)
      end

      element = create(element, element_id, &block)
      self.current_view.addSubview(element)

      element
    end

    # Retrieves a view by its element id.  This will return the *last* view
    # created with this element_id.
    def get(element_id)
      self.view
      self.element_ids[element_id].last
    end
    alias last get

    # Returns all the elements with a given element_id
    def all(element_id)
      self.view
      self.element_ids[element_id]
    end

    # Retrieves a view by its element id.  This will return the *first* view
    # created with this element_id.
    def first(element_id)
      self.view
      self.element_ids[element_id].first
    end

    # Retrieves a view by its element id and index in the stack.
    def nth(element_id, n)
      self.view
      self.element_ids[element_id][n]
    end

    # Removes a view (or several with the same name) from its hierarchy
    # and forgets it entirely.
    def remove(element_id)
      self.element_ids[element_id].each &:removeFromSuperview
      self.element_ids[element_id] = []
      nil
    end

  protected

    def element_ids
      @element_ids ||= Hash.new &lambda { |hash, key| hash[key] = [] }.weak!
    end

    def current_view
      @view_stack.last
    end

    # Initializes an instance of a view. This will need
    # to be smarter going forward as `new` isn't always
    # the designated initializer.
    def initialize_view(elem)
      elem = elem.new if elem.is_a?(Class)
      elem
    end

  public

    # this last little "catch-all" method is helpful to warn against methods
    # that are defined already
    def self.method_added(method_name)
      if Layout.method_defined?(method_name)
        NSLog("Warning! The method #{self.name}##{method_name} has already been defined on MotionKit::Layout or one of its ancestors.")
      end
    end

  end
end
