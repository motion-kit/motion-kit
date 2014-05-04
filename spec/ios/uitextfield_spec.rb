describe 'UITextField Layout and objc-style selectors' do

  before do
    @layout = TestTextFieldLayout.new
    @layout.view
  end

  it 'should set autocorrectionType' do
    @layout.get(:field).autocorrectionType.should == UITextAutocorrectionTypeNo
    @layout.get(:field).spellCheckingType.should == UITextSpellCheckingTypeNo
    @layout.get(:field).autocapitalizationType.should == UITextAutocapitalizationTypeNone
  end

end
