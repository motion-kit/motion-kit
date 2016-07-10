describe 'Remove views' do
  before do
    @subject = TestRemoveLayout.new.build
  end

  it 'should remove the #label view' do
    @subject.get(:label).should.be.kind_of(UILabel)
    @subject.remove_label
    @subject.get(:label).should.be.nil
  end

  it 'should remove the first label view' do 
    labels = @subject.all(:multi_label)
    labels.count.should == 2
    @subject.remove_first_multi_label
    @subject.all(:multi_label).count.should == 1
    @subject.get(:multi_label).should == labels.last
  end

  it 'should remove the last label view' do 
    labels = @subject.all(:multi_label)
    labels.count.should == 2
    @subject.remove_last_multi_label
    @subject.all(:multi_label).count.should == 1
    @subject.get(:multi_label).should == labels.first
  end


  it 'should forget the #image view' do
    image = @subject.get(:image)
    image.should.be.kind_of(UIImageView)
    @subject.forget_image
    @subject.get(:image).should.be.nil
    image.superview.should.not.be.nil
  end

  it 'should forget the first label view' do 
    labels = @subject.all(:multi_label)
    labels.count.should == 2
    @subject.forget_first_multi_label
    @subject.all(:multi_label).count.should == 1
    @subject.get(:multi_label).should == labels.last
    labels.first.superview.should.not.be.nil
  end


  it 'should remove the #view from the hierarchy' do
    view = @subject.get(:view)
    view.should.be.kind_of(UIView)
    @subject.remove_main_view
    @subject.get(:view).should.be.nil
    view.superview.should.be.nil
  end

end
