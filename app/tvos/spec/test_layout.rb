class TestLayout < MotionKit::Layout
  attr :first_view
  attr :last_view
  attr :nth_view

  def layout
    add UIView, :basic_view do
      add UIButton, :basic_button do
      end
      add UILabel, :basic_label
    end

    add UIView, :multiple_views do
      @first_view = add UIView, :repeated_label_3
      add UIView, :repeated_label_3
      add UIView, :repeated_label_3
      @nth_view = add UIButton, :repeated_label_3
      @last_view = add UILabel, :repeated_label_3
    end
  end

  def other_view
    @other_view ||= create(UIView, :other_view) do
      # is this allowed?  I can't think of an easy way of *preventing* it...
      self.layout
    end
  end

end
