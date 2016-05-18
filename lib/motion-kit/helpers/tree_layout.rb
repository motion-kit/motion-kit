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
      #
      # You can also set multiple views in a single line.
      #
      # @example
      #     class MyLayout < MK::Layout
      #       view :label, :login_button
      #     end
      def view(*names)
        names.each do |name|
          ivar_name = "@#{name}"
          define_method(name) do
            unless instance_variable_get(ivar_name)
              view = self.get_view(name)
              unless view
                build_view unless @view
                view = instance_variable_get(ivar_name) || self.get_view(name)
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

    end

    def initialize(args={})
      super
      @child_layouts = []
      @reapply_blocks = []
      @elements = {}
    end

    # The main view.  This method builds the layout and returns the root view.
    def view
      unless is_parent_layout?
        return parent_layout.view
      end
      @view ||= build_view
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
      end

      style_and_context(@view, element_id, &block)

      return @view
    end

    # instantiates a view, possibly running a 'layout block' to add child views.
    def create(element, element_id=nil, &block)
      element = initialize_element(element, element_id)
      style_and_context(element, element_id, &block)

      element
    end

    # Calls the style method of all objects in the view hierarchy that are
    # part of this layout.  The views in a child layout are not styled, but
    # those layouts will receive a `reapply!` message if no root is specified.
    def reapply!
      root ||= self.view
      @layout_state = :reapply
      run_reapply_blocks

      @child_layouts.each do |child_layout|
        child_layout.reapply!
      end

      @layout_state = :initial

      return self
    end

    def reapply?
      @layout_state == :reapply
    end

    # Only intended for private use
    def reapply_blocks
      @reapply_blocks ||= []
    end

    # Blocks passed to `reapply` are only run when `reapply!` is called.
    def reapply(&block)
      raise ArgumentError.new('Block required') unless block
      raise InvalidDeferredError.new('reapply must be run inside of a context') unless @context

      if reapply?
        yield
      end

      block = block.weak!
      parent_layout.reapply_blocks << [@context, block]
      return self
    end

    # Only intended for private use
    def run_reapply_blocks
      self.reapply_blocks.each do |target, block|
        context(target, &block)
      end
    end

    def initial?
      @layout_state == :initial
    end

    def always(&block)
      raise ArgumentError.new('Block required') unless block

      if initial?
        yield
      end
      reapply(&block)

      return self
    end

    def initial(&block)
      raise ArgumentError.new('Block required') unless block
      puts('the `initial` method is no longer necessary!  all code that *isn\'t in a `reapply` block is now only applied during initial setup.')

      if initial?
        yield
      end
      return self
    end

    def name_element(element, element_id)
      element.motion_kit_id = element_id
      @elements[element_id] ||= []
      @elements[element_id] << element
    end

    # Instantiates a view via `create` and adds the view to the current target.
    # If there is no context, a default root view can be created if that has
    # been enabled (e.g. within the `layout` method).  The block is run in the
    # context of the new view.
    def add(element, element_id=nil, &block)
      # make sure we have a target - raises NoContextError if none exists
      self.target

      unless @context
        create_default_root_context
      end

      # We want to be sure that the element has a supeview or superlayer before
      # the style method is called.
      element = initialize_element(element, element_id)
      self.apply(:add_child, element)
      style_and_context(element, element_id, &block)

      element
    end

    def child_layouts
      @child_layouts
    end

    # Retrieves a view by its element id.  This will return the *first* view
    # with this element_id in the tree, where *first* means the first object
    # that was added with that name.
    def get(element_id)
      unless is_parent_layout?
        return parent_layout.get(element_id)
      end
      @elements[element_id] && @elements[element_id].first
    end
    def first(element_id) ; get(element_id) ; end

    # Just like `get`, but if `get` returns a Layout, this method returns the
    # layout's view.
    def get_view(element_id)
      element = get(element_id)
      if element.is_a?(Layout)
        element = element.view
      end
      element
    end

    # Retrieves a view by its element id.  This will return the *last* view with
    # this element_id in the tree, where *last* means the last object that was
    # added with that name.
    def last(element_id)
      unless is_parent_layout?
        return parent_layout.last(element_id)
      end
      @elements[element_id] && @elements[element_id].last
    end

    # Just like `last`, but if `last` returns a Layout, this method returns the
    # layout's view.
    def last_view(element_id)
      element = last(element_id)
      if element.is_a?(Layout)
        element = element.view
      end
      element
    end

    # Returns all the elements with a given element_id
    def all(element_id)
      unless is_parent_layout?
        return parent_layout.all(element_id)
      end
      @elements[element_id] || []
    end

    # Just like `all`, but if `all` returns a Layout, this method returns the
    # layout's view.
    def all_views(element_id)
      element = all(element_id)
      if element.is_a?(Layout)
        element = element.view
      end
      element
    end

    # Returns the ‘N’th element with a given element_id, where "‘N’th" is passed
    # in as `index`
    def nth(element_id, index)
      self.all(element_id)[index]
    end

    # Just like `nth`, but if `nth` returns a Layout, this method returns the
    # layout's view.
    def nth_view(element_id, index)
      element = nth(element_id)
      if element.is_a?(Layout)
        element = element.view
      end
      element
    end

    # Search for a sibling: the next sibling that has the given id
    def next(element_id)
      self.next(element_id, from: target)
    end

    def next(element_id, from: from_view)
      unless is_parent_layout?
        return parent_layout.next(element_id, from: from_view)
      end
      search = @elements[element_id]
      if search.nil? || search.empty?
        return nil
      end

      if from_view.is_a?(NSString)
        from_view = self.get(from_view)
      end

      if from_view.is_a?(ConstraintsTarget)
        from_view = from_view.view
      end

      searching = false
      found = nil
      MotionKit.siblings(from_view).each do |sibling|
        if sibling == from_view
          searching = true
        elsif searching && search.include?(sibling)
          found = sibling
          break
        end
      end
      return found
    end

    # Search for a sibling: the previous sibling that has the given id
    def prev(element_id)
      prev(element_id, from: target)
    end

    def prev(element_id, from: from_view)
      unless is_parent_layout?
        return parent_layout.prev(element_id, from: from_view)
      end

      search = @elements[element_id]
      if search.nil? || search.empty?
        return nil
      end

      if from_view.is_a?(NSString)
        from_view = self.get(from_view)
      end

      if from_view.is_a?(ConstraintsTarget)
        from_view = from_view.view
      end

      found = nil
      MotionKit.siblings(from_view).each do |sibling|
        if sibling == from_view
          break
        elsif search.include?(sibling)
          # keep searching; prev should find the *closest* matching view
          found = sibling
        end
      end
      return found
    end

    # This searches for the "nearest" view with a given id.  First, all child
    # views are checked.  Then the search goes up to the parent view, and its
    # child views are checked.  This means *any* view that is in the parent
    # view's hierarchy is considered closer than a view in a grandparent's
    # hierarchy.  This is a "depth-first" search, so any subview that contains
    # a view with the element id
    #
    # A--B--C--D*   Starting at D, E is closer than F, because D&E are siblings.
    #  \  \  \-E    But F, G and H are closer than A or I, because they share a
    #   \  \-F--G   closer *parent* (B).  The logic is, "B" is a container, and
    #    \-I  \-H   all views in that container are in a closer family.
    def nearest(element_id)
      nearest(element_id, from: target)
    end

    def nearest(element_id, from: from_view)
      unless is_parent_layout?
        return parent_layout.nearest(element_id, from: from_view)
      end

      search = @elements[element_id]
      if search.nil? || search.empty?
        return nil
      end

      if from_view.is_a?(NSString)
        from_view = self.get(from_view)
      end

      if from_view.is_a?(ConstraintsTarget)
        from_view = from_view.view
      end

      MotionKit.nearest(from_view) { |test_view| search.include?(test_view) }
    end

    # Removes a view (or several with the same name) from the hierarchy
    # and forgets it entirely.  Returns the views that were removed.
    def remove(element_id)
      unless is_parent_layout?
        return parent_layout.remove(element_id)
      end
      removed = forget(element_id)
      context(self.view) do
        removed.each do |element|
          self.apply(:remove_child, element)
        end
      end
      removed
    end

    def remove_view(element_id, view)
      unless is_parent_layout?
        return parent_layout.remove_view(element_id, view)
      end
      removed = forget_view(element_id, view)
      if removed
        context(self.view) do
          self.apply(:remove_child, removed)
        end
      end
      removed
    end

    # Removes a view from the list of elements this layout is "tracking", but
    # leaves it in the view hierarchy.  Returns the views that were removed.
    def forget(element_id)
      unless is_parent_layout?
        return parent_layout.remove(element_id)
      end
      removed = nil
      context(self.view) do
        removed = all(element_id)
        @elements[element_id] = nil
      end
      removed
    end

    def forget_view(element_id, view)
      unless is_parent_layout?
        return parent_layout.remove_view(element_id, view)
      end
      removed = nil
      context(self.view) do
        removed = @elements[element_id].delete(view)
      end
      removed
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
          name_element(layout, element_id)
        end
        @child_layouts << layout
      elsif element_id
        name_element(elem, element_id)
      end

      return elem
    end

    # Calls the `_style` method with the element as the context, and runs the
    # optional block in that context.  This is usually done immediately after
    # `initialize_element`, except in the case of `add`, which adds the item to
    # the tree before styling it.
    def style_and_context(element, element_id, &block)
      style_method = "#{element_id}_style"
      if parent_layout.respond_to?(style_method) || block_given?
        parent_layout.context(element) do
          if parent_layout.respond_to?(style_method)
            parent_layout.send(style_method)
          end

          if block_given?
            yield
          end
        end
      end
    end

  end

end
