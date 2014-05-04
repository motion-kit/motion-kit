describe 'UIButton Layout and objc-style selectors' do

  before do
    @layout = TestButtonLayout.new
    @layout.view
  end

  it 'should set the title' do
    @layout.get(:button).currentTitle.should == TestButtonLayout::TITLE
  end

  it 'should set the highlighted title' do
    @layout.get(:button).titleForState(UIControlStateHighlighted).should == TestButtonLayout::HIGHLIGHTED_TITLE
  end

  it 'should set the image' do
    @layout.get(:button).currentImage.should == TestButtonLayout::IMAGE
  end

  it 'should set the highlighted image' do
    @layout.get(:button).imageForState(UIControlStateHighlighted).should == TestButtonLayout::HIGHLIGHTED_IMAGE
  end

end
