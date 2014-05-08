class TestRelativeLayout < MotionKit::Layout

  def layout
    add UIView, :test do
      frame from_top_left(w: "100%", h: 100)
      background_color UIColor.redColor
    end

    add UIView, :test2 do
      frame below(:test, w: "100%", h: 50)
      background_color UIColor.greenColor
    end
  end

end

