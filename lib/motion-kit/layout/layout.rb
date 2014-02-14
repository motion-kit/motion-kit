module MotionKit
  class Layout

    def view
      @view ||= build_layout
    end

    def add(elem, stylename)
      @view_hierarchy ||= [ self.view ]
      elem = initialize_view(elem)
      self.current_view.addSubview(elem)
      if block_given?
        @view_hierarchy << elem
        yield
        @view_hierarchy.pop
      end
    end

    private

    def current_view
      @view_hierarchy.last
    end

    def build_layout
      view = UIView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)

      if respond_to?(:layout)
        layout
      end
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
