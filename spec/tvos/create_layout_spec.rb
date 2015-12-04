describe 'Create Layout' do
  before do
    @subject = TestCreateLayout.new
  end

  it 'should create a view' do
    @subject.create_view.should.not == nil
  end

  it 'should create a UIView' do
    @subject.create_view.should.be.kind_of(UIView)
  end

  it 'should create a new view every time' do
    create_view1 = @subject.create_view
    create_view2 = @subject.create_view
    create_view1.should.not == create_view2
  end

  it 'should create a view without a superview' do
    @subject.create_view.superview.should == nil
  end

  it 'should add a label to the view' do
    @subject.create_view.subviews.first.should.be.kind_of(UILabel)
  end

  it 'should not add an image view' do
    @subject.create_view.subviews.find { |view| view.is_a?(UIImageView) }.should == nil
  end

  it 'should allow a view to be returned ' do
    @subject.create_and_context.should.not == nil
  end

  it 'should create a UIView via context' do
    @subject.create_and_context.should.be.kind_of(UIView)
  end

end
