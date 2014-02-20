class TestRemoveLayout < MotionKit::Layout

  def layout
    root UIView, :view do
      add UILabel, :label
      add UIImageView, :image
    end
  end

  def remove_label
    remove :label
  end

  def remove_image
    remove :image
  end

  def remove_view
    remove :view
  end

end
