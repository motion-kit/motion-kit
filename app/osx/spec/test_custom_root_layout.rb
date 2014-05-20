class TestCustomRootLayout < MotionKit::Layout

  def layout
    root :blue_view do
      add NSButton, :basic_button do
        add NSTextField, :basic_label
      end
    end
  end

  def blue_view_style
    background_color NSColor.blueColor
  end

end

class TestCustomDuplicateRootLayout < TestCustomRootLayout

  def layout
    root NSScrollView, :blue_view do
      add NSButton, :basic_button do
        add NSTextField, :basic_label
      end
    end
  end

end

class TestNestedLayout < MotionKit::Layout

  def layout
    root :nested_view do
      add NSButton, :some_button
    end
  end

  def nested_view_style
    background_color NSColor.yellowColor
  end

  def some_button_style
    background_color NSColor.blackColor
  end

end

class TestNestedView < NSView

  def init
    super
    @layout = TestNestedLayout.new(root: self)
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
    background_color NSColor.purpleColor
  end

end
