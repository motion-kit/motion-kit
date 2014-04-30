# @provides MotionKit::ViewLayout
# @requires MotionKit::BaseLayout
module MotionKit
  # A sensible parent class for any View-like layout class. Platform agnostic.
  # Any platform-specific tasks are offloaded to child views (add_child,
  # remove_child).
  # Actually, "view like" is misleading, since technically it only assumes "tree
  # like". You could use a ViewLayout subclass to construct a hierarchy
  # representing a family tree, for instance. But that would be a silly use of
  # MotionKit.
  class ViewLayout < BaseLayout

    # The parent view.  This method builds the layout and returns the root view.
    def view
      @view ||= build_view
    end

    # Assign a view to act as the 'root' view for this layout.  This method can
    # only be called once, and must be called before `add` is called for the
    # first time (otherwise `add` will create a default root view).  This method
    # must be called from inside `layout`, otherwise you should just use
    # `create`.
    #
    # You can also call this method with just an element_id, and the default
    # root view will be created.
    def root(element, element_id=nil, &block)
      if @view
        raise ContextConflictError.new("Already created the root view")
      end
      if @context
        raise ContextConflictError.new("Already in a context")
      end
      unless @assign_root
        raise InvalidRootError.new("You should only create a 'root' view from inside the 'layout' method (use 'create' elsewhere)")
      end
      @assign_root = false

      # this method can be called with just a symbol, to assign the root element_id
      if element.is_a?(Symbol)
        element_id = element
        # See note below about why we don't need to `apply(:default_root)`
        element = default_root
      end

      @view = initialize_view(element)
      if block
        context(@view) do
          # We're just using the `create` method for its side effects: calling the
          # style method and calling the block.
          create(@view, element_id, &block)
        end
      elsif element_id
        create(@view, element_id)
      end

      return @view
    end

    # instantiates a view, possibly running a 'layout block' to add child views.
    def create(element, element_id=nil, &block)
      element = initialize_view(element)

      if element_id
        # We set the optional id and call the '_style' method, if it's been
        # defined.
        element.motion_kit_id = element_id
        self.call_style_method(element, element_id)
      end

      if block
        context(element, &block)
      end

      element
    end

    def call_style_method(element, element_id)
      style_method = "#{element_id}_style"
      if @layout.respond_to?(style_method)
        @layout.context(element) do
          @layout.send(style_method)
        end
      end
      return element
    end

    # Calls the style method of all objects in the view hierarchy
    def reapply!(root=nil)
      root ||= self.view
      @layout_state = :reapply
      MotionKit.find_all_views(root) do |view|
        call_style_method(view, view.motion_kit_id) if view.motion_kit_id
      end
      @layout_state = :initial

      return self
    end

    # Calls the style method of all objects in the view hierarchy
    def reapply(&block)
      raise ArgumentError.new('Block required') unless block

      if @layout_state == :reapply
        yield
      end
      return self
    end

    def initial(&block)
      raise ArgumentError.new('Block required') unless block

      if @layout_state == :initial
        yield
      end
      return self
    end

    # Delegates to `create` to instantiate a view and run a layout block, and
    # adds the view to the current view on the view stack.  If no view exists on
    # the stack, a default root view can be created if that has been enabled.
    def add(element, element_id=nil, &block)
      # make sure we have a target - raises NoContextError if none exists
      self.target

      element = initialize_view(element)
      self.apply(:add_child, element)
      create(element, element_id, &block)

      element
    end

    # Retrieves a view by its element id.  This will return the *first* view
    # with this element_id in the tree, where *first* means the view closest to
    # the root view. Aliased to `first` to distinguish it from `last`.
    def get(element_id)
      if @layout && @layout != self
        return @layout.get(element_id)
      end
      self.get(element_id, in: self.view)
    end
    def first(element_id) ; get(element_id) ; end

    # Same as `get`, but with the root view specified.
    def get(element_id, in: root)
      MotionKit.find_first_view(root) { |view| view.motion_kit_id == element_id }
    end
    def first(element_id, in: root) ; get(element_id, in: root) ; end

    # Retrieves a view by its element id.  This will return the *last* view
    # with this element_id, where last means the view deepest and furthest from
    # the root view.
    def last(element_id)
      if @layout && @layout != self
        return @layout.last(element_id)
      end
      self.last(element_id, in: self.view)
    end

    # Same as `last`, but with the root view specified.
    def last(element_id, in: root)
      MotionKit.find_last_view(root) { |view| view.motion_kit_id == element_id }
    end

    # Returns all the elements with a given element_id in the view tree.
    def all(element_id)
      if @layout && @layout != self
        return @layout.all(element_id)
      end
      self.all(element_id, in: self.view)
    end

    # Same as `all`, but with the root view specified.
    def all(element_id, in: root)
      MotionKit.find_all_views(root) { |view| view.motion_kit_id == element_id }
    end

    # Returns all the elements with a given element_id
    def nth(element_id, index)
      if @layout && @layout != self
        return @layout.nth(element_id, index)
      end
      self.all(element_id, in: self.view)[index]
    end

    # Same as `nth`, but with the root view specified.
    def nth(element_id, at: index, in: root)
      self.all(element_id, in: root)[index]
    end

    # Removes a view (or several with the same name) from the hierarchy
    # and forgets it entirely.  Returns the views that were removed.
    def remove(element_id)
      if @layout && @layout != self
        return @layout.remove(element_id)
      end
      self.remove(element_id, from: self.view)
    end

    # Same as `remove`, but with the root view specified.
    def remove(element_id, from: root)
      context(root) do
        all(element_id).each do |subview|
          self.apply(:remove_child, subview)
        end
      end
    end

    def create_default_root_context
      if @assign_root
        # Originally I thought default_root should be `apply`ied like other
        # view-related methods, but actually this method *only* gets called
        # from within the `layout` method, and so should already inside the
        # correct Layout subclass.
        @context = root(default_root)
      else
        raise NoContextError.new("No top level view specified (missing outer 'create' method?)")
      end
    end

  protected

    # This method builds the layout and returns the root view.
    def build_view
      # Only in the 'layout' method will we allow default container to be
      # created automatically (when 'add' is called)
      @assign_root = true
      layout
      unless @view
        if @assign_root
          create_default_root_context
        else
          NSLog('Warning! No root view was set in ViewLayout#layout. Did you mean to call `root`?')
        end
      end
      @assign_root = false
      # context can be set via the 'create_default_root_context' method, which
      # may be outside a 'context' block, so make sure to restore context to
      # it's previous value
      @context = nil

      @view
    end

    def layout
    end

    # Initializes an instance of a view. This will need to be smarter going
    # forward as `new` isn't always the designated initializer.
    #
    # Accepts a view instance, a class (which is instantiated with 'new') or a
    # `ViewLayout`, which returns the root view.
    def initialize_view(elem)
      if elem.is_a?(Class) && elem < ViewLayout
        elem = elem.new_child(@layout, nil, self).view
      elsif elem.is_a?(Class)
        elem = elem.new
      elsif elem.is_a?(ViewLayout)
        elem = elem.view
      end

      return elem
    end

  end

end
