class TestLayout < MotionKit::Layout
  def layout
    add UIView, :basic_view do
      add UIButton, :basic_button do
      end
      add UILabel, :basic_label do
      end
    end
  end
end
