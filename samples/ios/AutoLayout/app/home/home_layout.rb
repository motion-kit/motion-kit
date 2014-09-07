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

    emoticons = [
      { name: 'Happy',       icon: UIImage.imageNamed('icon_happy'),       },
      { name: 'Sad',         icon: UIImage.imageNamed('icon_sad'),         },
      { name: 'Indifferent', icon: UIImage.imageNamed('icon_indifferent'), },
    ]
    emoticons.each do |info|
      add UIView, :avatar_row do
        add UIImageView, :avatar_icon do
          image info[:icon]
        end
        add UILabel, :avatar_label do
          text info[:name]
        end
      end
    end

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

  def avatar_row_style
    initial do
      constraints do
        left.equals(:superview)
        right.equals(:superview)
        height.equals(48)

        if target == first(:avatar_row)
          below(:switch).plus(20)
        else
          below(previous(:avatar_row))
        end
      end
    end
  end

  def avatar_icon_style
    initial do
      contentHuggingPriority(1000, forAxis: UILayoutConstraintAxisHorizontal)
      contentHuggingPriority(1000, forAxis: UILayoutConstraintAxisVertical)
      constraints do
        row = nearest(:avatar_row)
        center_y.equals(row)
        left.equals(row).plus(8)
      end
    end
  end

  def avatar_label_style
    initial do
      text_color UIColor.whiteColor
      constraints do
        row = nearest(:avatar_row)
        center_y.equals(row)
        left.equals(nearest(:avatar_icon), :right).plus(8)
        right.equals(row)
      end
    end
  end

end

