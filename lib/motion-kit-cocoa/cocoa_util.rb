module MotionKit
  module_function

  # - check view
  # - check subviews (unless 'skip' is provided)
  # - check siblings (skipping 'view')
  # - go up to parent and repeat, skipping children
  def nearest(view, skip=nil, &test)
    if view.nil?
      return nil
    end
    if test.call(view)
      return view
    end

    if view.is_a?(CALayer)
      children = view.sublayers
      siblings = view.superlayer ? view.superlayer.sublayers : []
      parent = view.superlayer
    else
      children = view.subviews
      siblings = view.superview ? view.superview.subviews : []
      parent = view.superview
    end

    found = nil

    # only check the children starting at the "root", e.g. nearest hasn't been
    # called recursively.
    if !skip || skip == parent
      children.each do |child|
        found = nearest(child, &test)
        break if found
      end
      return found if found
    end

    # siblings are closer than parents
    # passing 'parent' means only check self and children
    unless skip == parent
      siblings.each do |sibling|
        found = (sibling != view && nearest(sibling, parent, &test))
        break if found
      end
    end

    if found
      found
    elsif skip != parent
      nearest(parent, true, &test)
    end
  end

end
