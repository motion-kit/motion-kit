describe 'Child Layouts' do

  before do
    @layout = TestChildrenLayout.new.build
  end

  it 'should have 3 child layouts' do
    @layout.child_layouts.length.should == 3
  end

  it 'should have a layout named :child_button' do
    @layout.get_layout(:child_button).should.be.kind_of(ChildButtonLayout)
  end

  it 'should have a view named :child_button' do
    @layout.get(:child_button).should.be.kind_of(UIButton)
  end

  it 'should have a layout named :child_image' do
    @layout.get_layout(:child_image).should.be.kind_of(ChildImageLayout)
  end

  it 'should have a view named :child_image' do
    @layout.get(:child_image).should.be.kind_of(UIImageView)
  end

end
