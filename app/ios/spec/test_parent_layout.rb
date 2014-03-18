class TestParentLayout < MotionKit::Layout

  def layout
    add UIView, :basic_view do
      frame [[0, 0], [100, 60]]
      add UIButton, :basic_button do
        frame [[10, 10], [parent.width / 2, parent.height / 2]] # should be 50x30
        add UIView, :sub_sub_view do
          frame [ parent.center, [parent.width - 10, parent.height - 10]]
        end
      end
    end
  end

end
