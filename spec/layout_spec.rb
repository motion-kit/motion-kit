describe MotionKit::Layout do
  before { @subject = TestLayout.new }

  it "should be an instance of MotionKit::Layout" do
    @subject.should.be.kind_of(MotionKit::Layout)
  end

  it "should add a UIView subview with the name :basic_view" do
    @subject.view.subviews.first.should.be.kind_of UIView
  end

  it "should add two subviews under :basic_view" do
    @subject.view.subviews.first.subviews.length.should == 2
  end

  it "should add a UIButton as the first subview under :basic_view" do
    @subject.view.subviews.first.subviews.first.should.be.kind_of UIButton
  end

  it "should add a UILabel as the second subview under :basic_view" do
    @subject.view.subviews.first.subviews[1].should.be.kind_of UILabel
  end

  it "should allow getting the subviews by their id" do
    @subject.view
    @subject.get(:basic_view).should.be.kind_of UIView
    @subject.get(:basic_button).should.be.kind_of UIButton
    @subject.get(:basic_label).should.be.kind_of UILabel
  end
end
