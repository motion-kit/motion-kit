describe MotionKit::Layout do
  before { @subject = TestRootLayout.new; @subject.view }

  it "should allow setting the root view" do 
    @subject.view.should.be.kind_of UIScrollView
  end

  it "should still create subviews" do
    @subject.view.subviews.first.should.be.kind_of UIButton
    @subject.view.subviews.first.subviews.first.should.be.kind_of UILabel
  end
end
