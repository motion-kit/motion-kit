describe 'Assigning explicit root view' do
  before { @subject = TestRootLayout.new }

  it "should allow setting the root view" do
    @subject.view.should.be.kind_of UIScrollView
  end

  it "should still create subviews" do
    @subject.view.subviews.first.should.be.kind_of UIButton
    @subject.view.subviews.first.subviews.first.should.be.kind_of UILabel
  end

  it "should call style method" do
    @subject.view
    @subject.scroll_view_styled.should == true
  end

  it "should call style method on simple root layout" do
    subject = TestSimpleRootLayout.new

    subject.view
    subject.label_styled.should == true
  end

  it "should raise exception if you try to specify two roots" do
    subject = TestDuplicateRootLayout.new

    -> do
      subject.view
    end.should.raise(MotionKit::ContextConflictError)
  end

  it "should raise exception if you don't add views inside the root" do
    subject = TestNoRootContextLayout.new

    -> do
      subject.view
    end.should.raise(MotionKit::NoContextError)
  end

  it 'should raise an exception when there is no context' do
    subject = TestNoContextLayout.new

    -> do
      subject.foo
    end.should.raise(MotionKit::NoContextError)
  end

  it 'should raise an exception when creating a root view outside of `layout`' do
    subject = TestInvalidRootContextLayout.new

    -> do
      subject.foo
    end.should.raise(MotionKit::InvalidRootError)
  end

end
