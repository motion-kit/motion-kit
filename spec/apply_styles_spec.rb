describe "Layouts automatically apply styles" do

  before do
    @subject = TestApplyStyles.new
  end

  it "should apply all styles" do
    @subject.view
    @subject.did_call_logo.should == true
    @subject.did_call_h1_label.should == true
    @subject.did_call_label.should == true
  end

end
