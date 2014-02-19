class TestRootLayout < MotionKit::Layout

  def layout
    root UIScrollView, :scroll_view do
      add UIButton, :basic_button do
        add UILabel, :basic_label
      end
    end
  end

end
