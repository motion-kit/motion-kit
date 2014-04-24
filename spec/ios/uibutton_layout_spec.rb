describe 'UIButton Layout' do

  before do
    @layout = TestButtonLayout.new
    @layout.view
  end

  it 'should set the title' do
    @layout.get(:button).currentTitle.should == TestButtonLayout::TITLE
  end

  it 'should set the image' do
    @layout.get(:button).currentImage.should == TestButtonLayout::IMAGE
  end

end
