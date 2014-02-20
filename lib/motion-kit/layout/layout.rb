module MotionKit
  class Layout
    include Styleable

    # The parent view.  This method builds the layout and returns the root view.
    def view
      @view ||= begin
        # only in the 'layout' method, we will create a default container and
        # add views to it.
        @assign_root = true
        layout
        @assign_root = false
        @styleable_context = nil

        # Since we can't rely on the app developers to not return something
        # screwy from their layout method, we'll return @view here.
        @view
      end
    end

    # Assign a view to act as the 'root' view for this layout.  This method can
    # only be called once, and must be called before `add` is called for the
    # first time (otherwise `add` will create a default root view).
    #
    # You can also call this method with just an element_id, and the default
    # root view will be created.
    def root(element, element_id=nil, &block)
      if @view
        raise ContextConflictError.new("Already created the root view")
      end
      unless @assign_root
        raise InvalidRootError.new("You should only create a 'root' view from inside the 'layout' method (use 'create' elsewhere)")
      end
      @assign_root = false

      # this method can be called with just a symbol, to assign the root element_id
      if element.is_a?(Symbol)
        element_id = element
        element = default_root
      end

      # before we run the block, the root @view must be assigned, and added to
      # the view_stack
      @view = initialize_view(element)
      context(@view) do
        create(@view, element_id, &block)
      end

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
        element.motion_kit_id = element_id
        self.apply_style(element, element_id)
      end

      # Make the element the new context
      if block
        context(element, &block)
      end

      element
    end

    def apply_style(element, element_id)
      style_method = "#{element_id}_style"
      if self.respond_to?(style_method)
        self.context(element) do
          self.send(style_method)
        end
      end
      return element
    end

    # Delegates to `create` to instantiate a view and run a layout block, and
    # adds the view to the current view on the view stack.  If no view exists on
    # the stack, a default root view is created.
    def add(element, element_id=nil, &block)
      unless @styleable_context
        if @assign_root
          @styleable_context = root(default_root)
        else
          raise NoContextError.new("No top level view specified (missing outer 'create' method?)")
        end
      end

      element = create(element, element_id, &block)
      @styleable_context.addSubview(element)

      element
    end

    # Retrieves a view by its element id.  This will return the *first* view
    # created with this element_id.
    def first(element_id)
      self.first(element_id, in: self.view)
    end

    def first(element_id, in: root)
      MotionKit::find_first_view(root) { |view| view.motion_kit_id == element_id }
    end

    # Retrieves a view by its element id.  This will return the *last* view
    # created with this element_id.
    def get(element_id)
      self.get(element_id, in: self.view)
    end
    def last(element_id) ; get(element_id) ; end

    def get(element_id, in: root)
      MotionKit::find_last_view(root) { |view| view.motion_kit_id == element_id }
    end
    def last(element_id, in: root) ; get(element_id, in: root) ; end

    # Returns all the elements with a given element_id
    def all(element_id)
      self.all(element_id, in: self.view)
    end

    def all(element_id, in: root)
      MotionKit::find_all_views(root) { |view| view.motion_kit_id == element_id }
    end

    # Returns all the elements with a given element_id
    def nth(element_id, index)
      self.all(element_id, in: self.view)[index]
    end

    def nth(element_id, at: index, in: root)
      self.all(element_id, in: root)[index]
    end

    # Removes a view (or several with the same name) from its hierarchy
    # and forgets it entirely.  Returns the views that were removed.
    def remove(element_id)
      all(element_id).each &:removeFromSuperview
    end

  protected

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
      if self < Layout && Layout.method_defined?(method_name)
        NSLog("Warning! The method #{self.name}##{method_name} has already been defined on MotionKit::Layout or one of its ancestors.")
      end
    end

  end
end
