class TestAppearance < MK::Appearance

  def build
    style UIView do
      background_color UIColor.orangeColor
    end

    style UIToolbar do
      bar_tint_color UIColor.blueColor
      background_image UIImage.imageNamed('Default-568h'), toolbar_position:UIToolbarPositionAny, bar_metrics:UIBarMetricsDefault
      shadow_image UIImage.imageNamed('Default-568h'), toolbar_position:UIToolbarPositionAny
    end

    style UITableViewCell do
      separator_inset UIEdgeInsetsMake(1.0, 2.0, 3.0, 4.0)
    end

    style UITableView do
      separator_inset UIEdgeInsetsMake(1.0, 2.0, 3.0, 4.0)
      section_index_color UIColor.purpleColor
      section_index_background_color UIColor.greenColor
      section_index_tracking_background_color UIColor.clearColor
    end
  end

end
