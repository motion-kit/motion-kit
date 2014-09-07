module MotionKit
  module_function

  def siblings(view)
    case view
    when CALayer
      view.superlayer ? view.superlayer.sublayers : []
    else
      view.superview ? view.superview.subviews : []
    end
  end

  def children(view)
    case view
    when CALayer
      view.sublayers
    else
      view.subviews
    end
  end

  def parent(view)
    case view
    when CALayer
      view.superlayer
    else
      view.superview
    end
  end

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

    children = MotionKit.children(view)
    siblings = MotionKit.siblings(view)
    parent = MotionKit.parent(view)

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
