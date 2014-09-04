describe 'Relative Layouts' do
  before do
    @subject = TestRelativeLayout.new.build
  end

  it "should have two subviews" do
    @subject.view.subviews.count.should == 2
  end

  describe "should have a test view" do
    it "with origin x = y = 0" do
      @subject.get(:test).frame.origin.x.should == 0
      @subject.get(:test).frame.origin.y.should == 0
    end
    it "with frame w = h = 100" do
      @subject.get(:test).frame.size.width.should == UIScreen.mainScreen.bounds.size.width
      @subject.get(:test).frame.size.height.should == 100
    end
  end

  describe "should have a test2 view below test view" do
    it "with origin x = 0, y = 100" do
      @subject.get(:test2).frame.origin.x.should == 0
      @subject.get(:test2).frame.origin.y.should == 100
    end
    it "with frame w = 100, h = 50" do
      @subject.get(:test2).frame.size.width.should == UIScreen.mainScreen.bounds.size.width
      @subject.get(:test2).frame.size.height.should == 50
    end
  end
end