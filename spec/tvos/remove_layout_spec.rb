describe 'Remove views' do
  before do
    @subject = TestRemoveLayout.new.build
  end

  it 'should remove the #label view' do
    @subject.get(:label).should.be.kind_of(UILabel)
    @subject.remove_label
    @subject.get(:label).should.be.nil
  end

  it 'should forget the #image view' do
    image = @subject.get(:image)
    image.should.be.kind_of(UIImageView)
    @subject.forget_image
    @subject.get(:image).should.be.nil
    image.superview.should.not.be.nil
  end

  it 'should remove the #view from the hierarchy' do
    view = @subject.get(:view)
    view.should.be.kind_of(UIView)
    @subject.remove_view
    @subject.get(:view).should.be.nil
    view.superview.should.be.nil
  end

end
