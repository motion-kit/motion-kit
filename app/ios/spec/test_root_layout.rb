class TestRootLayout < MotionKit::Layout

  def layout
    root UIScrollView, :scroll_view do
      add UIButton, :basic_button do
        add UILabel, :basic_label
      end
    end
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
