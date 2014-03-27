describe "Custom Layout" do

  before do
    @subject = TestCustomLayout.new
  end

  it 'should always use the correct Layout' do
    @subject.view.should.be.kind_of?(CustomLabel)
    @subject.view.text.should == 'custom text'
    @subject.view.attributedText.should.not == nil
  end

end
