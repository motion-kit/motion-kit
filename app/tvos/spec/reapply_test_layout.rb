class ReapplyTestLayout < MotionKit::Layout
  def layout
    add UIView, :top_left
    add UIView, :top
    add UIView, :top_right
    add UIView, :left
    add UIView, :center
    add UIView, :right
    add UIView, :bottom_left
    add UIView, :bottom
    add UIView, :bottom_right
  end

  def dim
    {w: 10, h:10}
  end

  def top_left_style
    frame from_top_left dim
  end
  def top_style
    frame from_top dim
  end
  def top_right_style
    frame from_top_right dim
  end
  def left_style
    frame from_left dim
  end
  def center_style
    frame from_center dim
  end
  def right_style
    frame from_right dim
  end
  def bottom_left_style
    frame from_bottom_left dim
  end
  def bottom_style
    frame from_bottom dim
  end
  def bottom_right_style
    frame from_bottom_right dim
  end
end