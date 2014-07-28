class TestChildrenLayout < MK::Layout

  def layout
    add UILabel, :label
    add ChildLabelLayout
    add ChildButtonLayout, :child_button
    add ChildImageLayout, :child_image
  end

  def label_style
    initial do
      text 'root foo'
    end
    reapply do
      text 'root reapplied'
    end
  end

end


class ChildLabelLayout < MK::Layout

  def layout
    root UILabel, :label
  end

  def label_style
    initial do
      text 'foo'
    end
    reapply do
      text 'reapplied'
    end
  end

end


class ChildButtonLayout < MK::Layout

  def layout
    root UIButton, :button
  end

  def button_style
    initial do
      title 'foo'
    end
    reapply do
      title 'reapplied'
    end
  end

end


class ChildImageLayout < MK::Layout

  def layout
    root UIImageView, :image
  end

  def blank_image
    @blank_image ||= begin
      UIGraphicsBeginImageContextWithOptions([10, 10], false, UIScreen.mainScreen.scale)
      blank_image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      blank_image
    end
  end

  def reapplied_image
    @reapplied_image ||= begin
      UIGraphicsBeginImageContextWithOptions([11, 11], false, UIScreen.mainScreen.scale)
      reapplied_image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      reapplied_image
    end
  end

  def image_style
    initial do
      image blank_image
    end
    reapply do
      image reapplied_image
    end
  end

end
