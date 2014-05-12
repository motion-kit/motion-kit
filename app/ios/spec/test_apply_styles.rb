class TestApplyStyles < MotionKit::Layout
  attr :did_call_logo
  attr :did_call_h1_label
  attr :did_call_label

  def layout
    add UILabel, :logo
    add UILabel, :label do
      text ':label'
    end
  end

  def logo_style
    @did_call_logo = true
    text 'MK'
  end

  def h1_label_style
    @did_call_h1_label = true
    font UIFont.fontWithName('Avenir-Roman', size: 16)
  end

  def label_style
    @did_call_label = true
    self.h1_label_style
    text_color UIColor.blackColor
    number_of_lines 2
  end

end
