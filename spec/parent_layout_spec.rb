describe "layout parent methods" do

  before do
    @subject = TestParentLayout.new.view.subviews.first
  end

  it "should be a UIView" do
    @subject.should.be.kind_of UIView
  end

  it "should set the first subview frame properly" do
    @subject.frame.should == CGRectMake(0, 0, 100, 60)
  end

  it "should use parent to set its frame properly" do
    @subject.subviews.first.frame.should == CGRectMake(10, 10, 50, 30)
    @subject.subviews.first.subviews.first.frame.should == CGRectMake(25, 15, 40, 20)
  end

end
