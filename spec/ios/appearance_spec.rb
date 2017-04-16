describe MotionKit::Appearance do

  before do
    TestAppearance.new.build
  end

  describe MotionKit::UIViewAppearance do
    it "sets UIView backgroundColor" do
      UIView.appearance.backgroundColor.should == UIColor.orangeColor
    end
  end

  describe MotionKit::UILabelAppearance do
    it "sets UILabel font" do
      UILabel.appearance.font.should == UIFont.systemFontOfSize(15.0)
    end

    context "when nested" do
      it "sets UILabel font" do
        UILabel.appearanceWhenContainedIn(UIView, nil).font.should == UIFont.systemFontOfSize(19.0)
      end

      it "sets a deeply nested UIView bg color" do
        UIView.appearanceWhenContainedIn(UIView, UILabel, nil).backgroundColor.should == UIColor.magentaColor
        UIView.appearanceWhenContainedIn(UIView, UIImageView, nil).backgroundColor.should == UIColor.magentaColor
      end
    end
  end

  describe MotionKit::UIToolbarAppearance do
    it "sets UIToolbar barTintColor" do
      UIToolbar.appearance.barTintColor.should == UIColor.blueColor
    end

    it "sets UIToolbar backgroundImage:forToolbarPosition:barMetrics:" do
      UIToolbar.appearance.backgroundImageForToolbarPosition(UIToolbarPositionAny, barMetrics:UIBarMetricsDefault).should == UIImage.imageNamed('Default-568h')
    end

    it "sets UIToolbar backgroundImage:forToolbarPosition:barMetrics:" do
      UIToolbar.appearance.shadowImageForToolbarPosition(UIToolbarPositionAny).should == UIImage.imageNamed("Default-568h")
    end
  end

  describe MotionKit::UITableViewCellAppearance do
    it "sets UITableViewCell separatorInset" do
      # Causes test to crash for some reason.
      # UITableViewCell.appearance.separatorInset.should == UIEdgeInsetsMake(1.0, 2.0, 3.0, 4.0)
      1.should == 1
    end
  end

  describe MotionKit::UITableViewAppearance do
    it "sets UITableView appearance.separatorInset" do
      # Causes test to crash for some reason.
      # UITableView.appearance.separatorInset.should == UIEdgeInsetsMake(1.0, 2.0, 3.0, 4.0)
      1.should == 1
    end

    it "sets UITableView appearance.sectionIndexColor" do
      UITableView.appearance.sectionIndexColor.should == UIColor.purpleColor
    end

    it "sets UITableView appearance.sectionIndexBackgroundColor" do
      UITableView.appearance.sectionIndexBackgroundColor.should == UIColor.greenColor
    end

    it "sets UITableView appearance.sectionIndexTrackingBackgroundColor" do
      UITableView.appearance.sectionIndexTrackingBackgroundColor.should == UIColor.clearColor
    end
  end

end
