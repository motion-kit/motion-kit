describe 'Custom Root Layouts' do
  before do
    @view = NSView.new
    @subject = TestCustomRootLayout.new(root: @view)
  end

  it "should set the root view to the @view instance" do
    @subject.view.should == @view
  end

  it "should still create subviews" do
    @subject.view.subviews.first.should.be.kind_of NSButton
    @subject.view.subviews.first.subviews.first.should.be.kind_of NSTextField
  end

  it "should call style method" do
    @subject.view.backgroundColor.should == NSColor.blueColor
  end

  it "should raise exception if you try to specify a root inside the layout too" do
    -> do
      subject = TestCustomDuplicateRootLayout.new(root: @view)
      subject.view
    end.should.raise(MotionKit::ContextConflictError)
  end

  it "should allow multiple nested layouts" do
    @subject = TestMultipleNestedLayout.new
    @subject.view.backgroundColor.should == NSColor.purpleColor
    @subject.view.subviews.first.should.be.kind_of TestNestedView
    @subject.view.subviews.first.backgroundColor.should == NSColor.yellowColor
    @subject.view.subviews.first.subviews.first.should.be.kind_of NSButton
    @subject.view.subviews.first.subviews.first.backgroundColor.should == NSColor.blackColor
  end

  it "shouldn't build if `build` or `view` aren't called" do
    @subject.built?.should == false
  end

  it "should build when `build` is called" do
    @subject.build
    @subject.built?.should == true
  end

  it "should build when `view` is called" do
    @subject.view
    @subject.built?.should == true
  end

  it "should allow bare styles in layout when root is specified in initializer" do
    @subject = TestNoRootLayout.new(root: @view).build
    @subject.view.should == @view
    @subject.view.backgroundColor.should == UIColor.redColor
    @subject.view.subviews.first.should.be.kind_of?(UILabel)
  end

end
