class HelloLayout < MotionKit::Layout

  attr_accessor :button, :label

  def layout
    @label  = add UILabel, :label
    @button = add UIButton, :button
  end

  def label_style
    text 'Hi there!'
    font UIFont.systemFontOfSize(76)
    size_to_fit
    width 800

    center ['50%', '50% + 50']
    text_alignment NSTextAlignmentCenter
    text_color UIColor.blackColor    
  end

  def button_style
    title "Press me!"
    
    layer do
      corner_radius 7.0
      
      # Can't find pointer description for type `{CGColor=}'
      # shadow_color UIColor.greenColor.CGColor
      
      shadow_opacity 0.9
      shadow_radius 2.0
      shadow_offset [0, 0]
    end
    
    constraints do
      top.equals(:label).plus(200)
      width.equals(:superview)
    end
  end

end
