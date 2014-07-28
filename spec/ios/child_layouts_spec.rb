describe 'Child Layouts' do

  before do
    @layout = TestChildrenLayout.new.build
  end

  it 'should have 3 child layouts' do
    @layout.child_layouts.length.should == 3
  end

  it 'should have a layout named :child_button' do
    @layout.get(:child_button).should.be.kind_of(ChildButtonLayout)
  end

  it ':child_button layout should have a view named :button' do
    @layout.get(:child_button).get(:button).should.be.kind_of(UIButton)
  end

  it 'should have a layout named :child_image' do
    @layout.get(:child_image).should.be.kind_of(ChildImageLayout)
  end

  it ':child_image layout should have a view named :image' do
    @layout.get(:child_image).get(:image).should.be.kind_of(UIImageView)
  end

  describe 'Calling reapply! on parent layout' do

    before do
      @layout.reapply!
    end

    it 'should reapply :label on root' do
      @layout.get(:label).text.should == 'root reapplied'
    end

    it 'should reapply :label on child layout' do
      @layout.child_layouts[0].get(:label).text.should == 'reapplied'
    end

    it 'should reapply :button on child layout' do
      @layout.get(:child_button).reapply!
      @layout.get(:child_button).get(:button).currentTitle.should == 'reapplied'
    end

    it 'should reapply :image on child layout' do
      reapplied_image = @layout.get(:child_image).reapplied_image
      @layout.get(:child_image).get(:image).image.should == reapplied_image
    end

  end

end
