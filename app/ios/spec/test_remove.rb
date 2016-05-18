class TestRemoveLayout < MotionKit::Layout

  def layout
    root UIView do
      add UIView, :view do
        add UILabel, :label
        add UIImageView, :image
        add UILabel, :multi_label
        add UILabel, :multi_label
      end
    end
  end

  def remove_label
    remove :label
  end

  def forget_image
    forget :image
  end

  def remove_main_view
    remove :view
  end

  def remove_first_multi_label
    remove_view :multi_label, first(:multi_label)
  end

  def forget_first_multi_label
    forget_view :multi_label, first(:multi_label)
  end

  def remove_last_multi_label
    remove_view :multi_label, last(:multi_label)
  end
end
