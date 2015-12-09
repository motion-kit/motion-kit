describe "Layouts automatically apply styles" do

  before do
    @subject = TestApplyStyles.new.build
  end

  describe "should call all style methods" do
    {
      logo:     -> { @subject.did_call_logo },
      h1_label: -> { @subject.did_call_h1_label },
      label:    -> { @subject.did_call_label },
    }.each do |name, condition|
      it "should call #{name} style method" do
        condition.call.should == true
      end
    end
  end

  describe "should apply all styles" do
    it 'should style :logo' do
      @subject.get(:logo).text.should == 'MK'
    end
    it 'should style :label' do
      @subject.get(:label).text.should == ':label'
    end
    it 'should style :label' do
      @subject.get(:label).numberOfLines.should == 2
    end
    it 'should style :label' do
      @subject.get(:label).font.pointSize.should == 16
    end
    it 'should style :label' do
      @subject.get(:label).textColor.should == UIColor.blackColor
    end
  end

end
