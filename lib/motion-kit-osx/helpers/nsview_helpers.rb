# @provides MotionKit::Layout
# @provides MotionKit::NSViewHelpers
# @requires MotionKit::TreeLayout
module MotionKit
  class Layout < TreeLayout

    # platform specific default root view
    def default_root
      # child Layout classes will return *their* NSView subclass from self.targets
      view_class = self.class.targets || MotionKit.default_view_class
      view_class.alloc.initWithFrame([[0, 0], [0, 0]])
    end

    def add_child(subview, options={})
      if (sibling = options[:behind])
        target.addSubview(subview, positioned: NSWindowBelow, relativeTo: sibling)
      elsif (sibling = options[:in_front_of])
        target.addSubview(subview, positioned: NSWindowAbove, relativeTo: sibling)
      elsif (z_index = options[:z_index])
        NSLog('Warning! :z_index option not supported in OS X when adding a child view')
      else
        target.addSubview(subview)
      end
    end

    def remove_child(subview)
      subview.removeFromSuperview
    end

  end

  class NSViewHelpers < Layout
    targets NSView
  end

end
