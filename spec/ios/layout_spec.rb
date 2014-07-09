describe 'Simple Layout' do
  before do
    @subject = TestLayout.new.build
  end

  it "should be an instance of MotionKit::Layout" do
    @subject.should.be.kind_of(MotionKit::Layout)
  end

  it "should be an instance of MK::Layout" do
    @subject.should.be.kind_of(MK::Layout)
  end

  it "should add a UIView subview with the name :basic_view" do
    view = @subject.get(:basic_view)
    view.should.be.kind_of(UIView)
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
    @subject.get(:basic_view).should.be.kind_of UIView
    @subject.get(:basic_button).should.be.kind_of UIButton
    @subject.get(:basic_label).should.be.kind_of UILabel
  end

  it "should allow getting the subviews by first, last and nth child" do
    @subject.first(:repeated_label_3).should.be.kind_of UIView
    @subject.nth(:repeated_label_3, 1).should.be.kind_of UIButton
    @subject.last(:repeated_label_3).should.be.kind_of UILabel
  end

  it "should allow getting all the subviews by name" do
    views = @subject.all(:repeated_label_3)
    views.length.should == 3
    views[0].should.be.kind_of UIView
    views[1].should.be.kind_of UIButton
    views[2].should.be.kind_of UILabel
  end

  it "should support missing methods" do
    -> do
      @subject.foo_bar_baz
    end.should.raise(NoMethodError)
  end

end
