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

  it 'should set the titleLabel font' do
    font = @layout.get(:button).titleLabel.font
    should_be_font = UIFont.fontWithName(TestButtonLayout::FONT, size: TestButtonLayout::SIZE)

    font.familyName.should == should_be_font.familyName
    font.pointSize.should == should_be_font.pointSize
  end

  it 'should set the titleLabel textAlignment' do
    alignment = @layout.get(:button).titleLabel.textAlignment
    alignment.should == NSTextAlignmentCenter
  end

end
