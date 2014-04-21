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

    add container, :container_view
  end

  def other_view
    @other_view ||= create(UIView, :other_view) do
      # is this allowed?  I can't think of an easy way of *preventing* it...
      self.layout
    end
  end

end
