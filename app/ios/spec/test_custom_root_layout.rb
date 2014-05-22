class TestCustomRootLayout < MotionKit::Layout

  def layout
    root :blue_view do
      add UIButton, :basic_button do
        add UILabel, :basic_label
      end
    end
  end

  def blue_view_style
    background_color UIColor.blueColor
  end

end

class TestCustomDuplicateRootLayout < TestCustomRootLayout

  def layout
    root UIScrollView, :blue_view do
      add UIButton, :basic_button do
        add UILabel, :basic_label
      end
    end
  end

end

class TestNestedLayout < MotionKit::Layout

  def layout
    root :nested_view do
      add UIButton, :some_button
    end
  end

  def nested_view_style
    background_color UIColor.yellowColor
  end

  def some_button_style
    background_color UIColor.blackColor
  end

end

class TestNestedView < UIView

  def init
    super
    @layout = TestNestedLayout.new(root: self).build
    self
  end

end

class TestMultipleNestedLayout < MotionKit::Layout

  def layout
    root :purple_view do
      add TestNestedView
    end
  end

  def purple_view_style
    background_color UIColor.purpleColor
  end

end

class TestNoRootLayout < MotionKit::Layout

  def layout
    background_color UIColor.redColor
    add UILabel, :purple_view
  end

  def purple_view_style
    background_color UIColor.purpleColor
  end

end
