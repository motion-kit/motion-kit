describe MotionKit::Parent do

  before do
    uiview = UIView.new
    uiview.frame = [[10, 20], [30, 40]]
    @subject = MotionKit::Parent.new(uiview)
  end

  it "should return the x value" do
    @subject.x.should == 10
  end

  it "should return the y value" do
    @subject.y.should == 20
  end

  it "should return the width value" do
    @subject.width.should == 30
  end

  it "should return the height value" do
    @subject.height.should == 40
  end

  it "should return the center_x value" do
    @subject.center_x.should == 15
  end

  it "should return the center_y value" do
    @subject.center_y.should == 20
  end

  it "should return the center point" do
    @subject.center.should == [15, 20]
  end

end
