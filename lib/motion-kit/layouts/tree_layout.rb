# @provides MotionKit::TreeLayout
# @requires MotionKit::BaseLayout
module MotionKit
  # A sensible parent class for any Tree-like layout class. Platform agnostic.
  # Any platform-specific tasks are offloaded to child elements (add_child,
  # remove_child). You could use a TreeLayout subclass to construct a hierarchy
  # representing a family tree, for instance. But that would be a silly use of
  # MotionKit.
  class TreeLayout < BaseLayout

    class << self

      # This is an `attr_reader`-like method that also calls `build_view` if the
      # @view doesn't exist, and so you can use it to refer to views that are
      # assigned to ivars in your `layout` method.
      #
      # @example
      #     class MyLayout < MK::Layout
      #       view :label
      #       view :login_button
      #
      #       def layout
      #         # if element id and attr name match, no need to assign to ivar
      #         add UILabel, :label
      #         # if they don't match you must assign.  If you are using
      #         # Key-Value observation you should use the setter:
      #         self.login_button = add UIButton, :button
      #       end
      #
      #     end
      def view(name)
        ivar_name = "@#{name}"
        define_method(name) do
          unless instance_variable_get(ivar_name)
            view = self.get(name)
            unless view
              build_view unless @view
              view = instance_variable_get(ivar_name) || self.get(name)
            end
            self.send("#{name}=", view)
            return view
          end
          return instance_variable_get(ivar_name)
        end
        # KVO compliance
        attr_writer name
      end

    end

    def initialize(args={})
      super
      @child_layouts = { by_name: {}, by_list: [] }
    end

    # The main view.  This method builds the layout and returns the root view.
    def view
      unless is_parent_layout?
        return parent_layout.view
      end
      @view ||= build_view
    end

    # For private use.  The "root" is context sensitive, whereas the "view" is
    # constant.  In most cases they are the same object, but when you are
    # building a hierarchy that is *outside* the view created from the "layout"
    # method, the top-most view in that hierarchy will be "root".
    def _root
      @root || view
    end

    # Builds the layout and then returns self for chaining.
    def build
      view
      self
    end

    # Checks if the layout has been built yet or not.
    def built?
      !@view.nil?
    end
    alias build? built? # just in case

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
      unless @assign_root
        raise InvalidRootError.new("You should only create a 'root' view from inside the 'layout' method (use 'create' elsewhere)")
      end
      @assign_root = false

      # this method can be called with just a symbol, to assign the root element_id
      if element.is_a?(Symbol)
        element_id = element
        # See note below about why we don't need to `apply(:default_root)`
        element = preset_root || default_root
      elsif preset_root && preset_root != element
        # You're trying to make two roots, one at initialization
        # and one in your layout itself.
        raise ContextConflictError.new("Already created the root view")
      end

      @view = initialize_element(element, element_id)
      if block
        if @context
          raise ContextConflictError.new("Already in a context")
        end

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
      element = initialize_element(element, element_id)

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
      if parent_layout.respond_to?(style_method)
        parent_layout.context(element) do
          parent_layout.send(style_method)
        end
      end
      return element
    end

    # Calls the style method of all objects in the view hierarchy
    def reapply!(root=nil)
      apply_to_children = !root

      root ||= self.view
      @layout_state = :reapply
      MotionKit.find_all_views(root) do |view|
        call_style_method(view, view.motion_kit_id) if view.motion_kit_id
      end

      if apply_to_children
        @child_layouts[:by_list].each do |child_layout|
          child_layout.reapply!
        end
      end
      @layout_state = :initial

      return self
    end

    def reapply?
      @layout_state == :reapply
    end

    # Calls the style method of all objects in the view hierarchy
    def reapply(&block)
      raise ArgumentError.new('Block required') unless block

      if reapply?
        yield
      end
      return self
    end

    def initial?
      @layout_state == :initial
    end

    def initial(&block)
      raise ArgumentError.new('Block required') unless block

      if initial?
        yield
      end
      return self
    end

    # Instantiates a view via `create` and adds the view to the current target.
    # If no view exists on the stack, a default root view can be created if that
    # has been enabled.  The block is run in the context of the new view.
    def add(element, element_id=nil, &block)
      # make sure we have a target - raises NoContextError if none exists
      self.target

      element = initialize_element(element, element_id)
      unless @context
        create_default_root_context
      end
      self.apply(:add_child, element)
      create(element, element_id)

      if block
        context(element, &block)
      end

      element
    end

    def child_layouts
      @child_layouts[:by_list]
    end

    # Retrieves a child layout by name
    def get_layout(element_id)
      @child_layouts[:by_name][element_id]
    end

    # Retrieves a view by its element id.  This will return the *first* view
    # with this element_id in the tree, where *first* means the view closest to
    # the root view. Aliased to `first` to distinguish it from `last`.
    def get(element_id)
      unless is_parent_layout?
        return parent_layout.get(element_id)
      end
      self.get(element_id, in: self._root)
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
      unless is_parent_layout?
        return parent_layout.last(element_id)
      end
      self.last(element_id, in: self._root)
    end

    # Same as `last`, but with the root view specified.
    def last(element_id, in: root)
      MotionKit.find_last_view(root) { |view| view.motion_kit_id == element_id }
    end

    # Returns all the elements with a given element_id in the view tree.
    def all(element_id)
      unless is_parent_layout?
        return parent_layout.all(element_id)
      end
      self.all(element_id, in: self._root)
    end

    # Same as `all`, but with the root view specified.
    def all(element_id, in: root)
      MotionKit.find_all_views(root) { |view| view.motion_kit_id == element_id }
    end

    # Returns all the elements with a given element_id
    def nth(element_id, index)
      self.all(element_id)[index]
    end

    # Same as `nth`, but with the root view specified.
    def nth(element_id, at: index, in: root)
      self.all(element_id, in: root)[index]
    end

    # Removes a view (or several with the same name) from the hierarchy
    # and forgets it entirely.  Returns the views that were removed.
    def remove(element_id)
      unless is_parent_layout?
        return parent_layout.remove(element_id)
      end
      self.remove(element_id, from: self._root)
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
        # from within the `layout` method, and so should already be inside the
        # correct Layout subclass.
        @context = root(preset_root || default_root)
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
      prev_should_run = @should_run_deferred
      @should_run_deferred = true
      layout
      unless @view
        if @assign_root
          create_default_root_context
          @view = @context
        else
          NSLog('Warning! No root view was set in TreeLayout#layout. Did you mean to call `root`?')
        end
      end
      run_deferred(@view)
      @should_run_deferred = prev_should_run
      @assign_root = false
      # context can be set via the 'create_default_root_context' method, which
      # may be outside a 'context' block, so make sure to restore context to
      # it's previous value
      @context = nil

      if @preset_root
        @view = WeakRef.new(@view)
        @preset_root = nil
      end

      @view
    end

    # This method needs to set the @root so that calls to `get(:id)` defer to
    # the "current root", not the layout root view.
    def run_deferred(top_level_context)
      root_was = @root
      @root = top_level_context
      retval = super
      @root = root_was

      return retval
    end

    def layout
    end

    # Initializes an instance of a view. This will need to be smarter going
    # forward as `new` isn't always the designated initializer.
    #
    # Accepts a view instance, a class (which is instantiated with 'new') or a
    # `ViewLayout`, which returns the root view.
    def initialize_element(elem, element_id)
      if elem.is_a?(Class) && elem < TreeLayout
        layout = elem.new
        elem = layout.view
      elsif elem.is_a?(Class)
        elem = elem.new
      elsif elem.is_a?(TreeLayout)
        layout = elem
        elem = elem.view
      end

      if layout
        if element_id
          @child_layouts[:by_name][element_id] = layout
        end
        @child_layouts[:by_list] << layout
      end

      return elem
    end

  end

end
