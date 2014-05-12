describe "Layouts automatically apply styles" do

  before do
    @subject = TestApplyStyles.new
  end

  it "should call all style methods" do
    @subject.view
    @subject.did_call_logo.should == true
    @subject.did_call_h1_label.should == true
    @subject.did_call_label.should == true
  end

  it "should apply all styles" do
    @subject.get(:logo).text.should == 'MK'
    @subject.get(:label).text.should == ':label'
    @subject.get(:label).numberOfLines.should == 2
    @subject.get(:label).font.pointSize.should == 16
    @subject.get(:label).textColor.should == UIColor.blackColor
  end

end
