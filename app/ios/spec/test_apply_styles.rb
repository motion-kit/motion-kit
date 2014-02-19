class TestApplyStyles < MotionKit::Layout
  attr :did_call_logo
  attr :did_call_h1_label
  attr :did_call_label

  def layout
    add UIView, :logo
    add UIView, :label
  end

  def logo
    @did_call_logo = true
  end

  def h1_label
    @did_call_h1_label = true
  end

  def label
    self.h1_label
    @did_call_label = true
  end

end
