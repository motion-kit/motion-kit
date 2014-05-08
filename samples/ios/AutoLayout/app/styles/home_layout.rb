class HomeLayout < MK::Layout
  include AppLayout

  VerticalPadding = 10

  view :label
  view :button
  view :switch

  def layout
    backgroundColor UIColor.grayColor

    @label = add(UILabel, :label)
    @button = add(UIButton, :button)
    @switch = add(UISwitch, :switch)
  end

  def add_constraints(controller)
    context(self.view) do
      constraints do
        origin [0, 0]
        width.equals(:superview)
        height.equals(:superview)
      end
    end

    constraints(:label) do
      below(controller.topLayoutGuide).plus(50)
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
    on true

    constraints do
      below(:button).plus(VerticalPadding)
      center_x.equals(:label)
    end
  end

end

