describe MotionKit::Layout do
  before do
    @subject = TestCreateLayout.new
  end

  it 'should create a view' do
    @subject.foo.should.not == nil
  end

  it 'should create a UIView' do
    @subject.foo.should.be.kind_of(UIView)
  end

  it 'should create a new view every time' do
    foo1 = @subject.foo
    foo2 = @subject.foo
    foo1.should.not == foo2
  end

  it 'should create a view without a superview' do
    @subject.foo.superview.should == nil
  end

  it 'should add a label to the view' do
    @subject.foo.subviews.first.should.be.kind_of(UILabel)
  end

  it 'should not add an image view' do
    @subject.foo.subviews.find { |view| view.is_a?(UIImageView) }.should == nil
  end
end