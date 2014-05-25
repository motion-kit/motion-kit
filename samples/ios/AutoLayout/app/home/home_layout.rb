class HomeLayout < MK::Layout
  attr_accessor :top_layout_guide
  include AppLayout

  VerticalPadding = 10

  view :label
  view :button
  view :switch
  view :segmented

  def layout
    backgroundColor UIColor.grayColor

    @label = add(UILabel, :label)
    @button = add(UIButton, :button)
    @switch = add(UISwitch, :switch)

    items = ['One', 'Two', 'Three']
    @segmented = UISegmentedControl.alloc.initWithItems(items)
    add(@segmented, :segmented)
  end

  def add_constraints(controller)
    constraints(self.view) do
      origin [0, 0]
      width.equals(:superview)
      height.equals(:superview)
    end

    constraints(:label) do
    end
  end

  def label_style
    initial do
      text 'App Stuff!'
      backgroundColor UIColor.clearColor
      numberOfLines 0
      font UIFont.boldSystemFontOfSize(40)
      textColor UIColor.whiteColor
      shadowColor UIColor.blackColor
      textAlignment UITextAlignmentCenter
      layer do
        shadowRadius 20
        shadowOpacity 0.5
        masksToBounds false
      end

      constraints do
        width('100%')
        center_x.equals(:superview)
        below(top_layout_guide).plus(50)
      end
    end
  end

  def button_style
    initial do
      title 'Button'

      constraints do
        below(:label).plus(VerticalPadding)
        center_x.equals(:label)
      end
    end
  end

  def switch_style
    initial do
      on true

      constraints do
        below(:button).plus(VerticalPadding)
        center_x.equals(:label)
      end
    end
  end

  def segmented_style
    initial do
      background_color UIColor.whiteColor

      constraints do
        below(top_layout_guide)
        center_x.equals(:superview)
      end

      selectedSegmentIndex 0
      addTarget(self, action: 'selected_segment', forControlEvents: UIControlEventValueChanged)
    end
  end

  def selected_segment
    index = @segmented.selectedSegmentIndex
    NSLog('Selected index %@', index)
  end

end

