describe MotionKit::Layout do
  before do
    @subject = TestRemoveLayout.new
  end

  it 'should remove the #label view' do
    @subject.get(:label).should.be.kind_of(UILabel)
    @subject.remove_label
    @subject.get(:label).should.be.nil
  end

  it 'should remove the #image view' do
    @subject.get(:image).should.be.kind_of(UIImageView)
    @subject.remove_image
    @subject.get(:image).should.be.nil
  end

  it 'should remove the #view view' do
    @subject.get(:view).should.be.kind_of(UIView)
    @subject.remove_view
    @subject.get(:view).should.be.nil
    @subject.get(:image).should.be.nil
  end

end
