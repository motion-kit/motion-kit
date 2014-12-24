describe "Layout extensions - iOS" do

  before do
    @subject = MK::UIViewHelpers.new
    @subject.instance_variable_set(:@context, "don't matter what i be, as long as i be.")
  end

  it 'should have `orientation?` method' do
    tf = @subject.orientation?(:portrait)
    (tf == true || tf == false).should.be.true
  end

  it 'should return true for `orientation?(:portrait)` when in portrait' do
    tf = @subject.orientation?(:portrait)
    should_be = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationPortrait)
    tf.should == should_be
  end

  it 'should return true for `orientation?(:landscape_left)` when in landscape_left' do
    tf = @subject.orientation?(:landscape_left)
    should_be = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeLeft)
    tf.should == should_be
  end

  it 'should return true for `orientation?(:landscape_right)` when in landscape_right' do
    tf = @subject.orientation?(:landscape_right)
    should_be = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeRight)
    tf.should == should_be
  end

  it 'should return true for `orientation?(:landscape)` when in landscape' do
    tf = @subject.orientation?(:landscape)
    should_be = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeLeft || UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeRight)
    tf.should == should_be
  end

  it 'should have `iphone?` method' do
    tf = @subject.iphone?
    (tf == true || tf == false).should.be.true
  end

  it 'should return `true` for `iphone?` when using an iphone' do
    tf = @subject.iphone?
    should_be = UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone
    tf.should == should_be
  end

  it 'should have `ipad?` method' do
    tf = @subject.ipad?
    (tf == true || tf == false).should.be.true
  end

  it 'should return `true` for `ipad?` when using an ipad' do
    tf = @subject.ipad?
    should_be = UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
    tf.should == should_be
  end

  it 'should have `retina?` method' do
    tf = @subject.retina?
    (tf == true || tf == false).should.be.true
  end

  it 'should return `true` for `return?` when using a retina device' do
    tf = @subject.retina?
    should_be = UIScreen.mainScreen.scale == 2
    tf.should == should_be
  end

end
