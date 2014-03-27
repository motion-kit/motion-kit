module MotionKit
  module_function

  # performs a breadth-first search
  def find_first_view(root, &condition)
    if condition.call(root)
      root
    else
      found = nil
      root.subviews.find do |subview|
        found = find_first_view(subview, &condition)
      end
      return found
    end
  end

  # performs a depth-first and reversed search
  def find_last_view(root, &condition)
    found = nil
    root.subviews.reverse.find do |subview|
      found = find_last_view(subview, &condition)
    end

    if ! found && condition.call(root)
      found = root
    end

    return found
  end

  # performs a breadth-first search, but returns all matches
  def find_all_views(root, &condition)
    found = []
    if condition.call(root)
      found << root
    end

    (root.subviews || []).each do |subview|
      found.concat(find_all_views(subview, &condition))
    end

    return found
  end

  # similar to find_all_views, but for CALayer
  def find_all_layers(root, &condition)
    found = []
    if condition.call(root)
      found << root
    end

    (root.sublayers || []).each do |sublayer|
      found.concat(find_all_layers(sublayer, &condition))
    end

    return found
  end

end
