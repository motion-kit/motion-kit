class TestChildrenLayout < MK::Layout

  def layout
    add UILabel, :label
    add ChildLabelLayout
    add ChildButtonLayout, :child_button
    add ChildImageLayout, :child_image
  end

  def label_style
    text 'root foo'

    reapply do
      text 'root reapplied'
    end
    always do
      tag 100
    end
  end

end


class ChildLabelLayout < MK::Layout

  def layout
    root UILabel, :label
  end

  def label_style
    text 'foo'

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
    title 'foo'

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
    image blank_image

    reapply do
      image reapplied_image
    end
  end

end
