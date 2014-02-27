class TestRootLayout < MotionKit::Layout
  attr :scroll_view_styled

  def layout
    root UIScrollView, :scroll_view do
      add UIButton, :basic_button do
        add UILabel, :basic_label
      end
    end
  end

  def scroll_view_style
    @scroll_view_styled = true
  end

end


class TestSimpleRootLayout < MotionKit::Layout
  attr :label_styled

  def layout
    root UILabel, :label
  end

  def label_style
    @label_styled = true
  end

end


class TestDuplicateRootLayout < MotionKit::Layout

  def layout
    root UIView
    root UIView
  end

end


class TestNoRootContextLayout < MotionKit::Layout

  def layout
    root UIView
    add UIView
  end

end


class TestNoContextLayout < MotionKit::Layout

  def foo
    add UIView
  end

end


class TestInvalidRootContextLayout < MotionKit::Layout

  def foo
    root UIView
  end

end
