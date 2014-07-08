class TestChildrenLayout < MK::Layout

  def layout
    add ChildLabelLayout
    add ChildButtonLayout, :child_button
    add ChildImageLayout, :child_image
  end

end


class ChildLabelLayout < MK::Layout

  def layout
    root UILabel
  end

end


class ChildButtonLayout < MK::Layout

  def layout
    root UIButton
  end

end


class ChildImageLayout < MK::Layout

  def layout
    root UIImageView
  end

end
