class TestLayout < MotionKit::Layout
  def layout
    add UIView, :basic_view do
      add UIButton, :basic_button do
      end
      add UILabel, :basic_label
    end

    add UIView, :multiple_views do
      add UIView, :repeated_label_3
      add UIButton, :repeated_label_3
      add UILabel, :repeated_label_3
    end
  end
end
