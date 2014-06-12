describe 'Views frames should remain unchanged' do

  before do
    @subject = ReapplyTestLayout.new
  end

  it "top_left should be in the right position before reapply" do
    @subject.get(:top_left).frame.should == CGRectMake(0,0,10,10)
  end

  it "top should be in the right position before reapply" do
    @subject.get(:top).frame.should == CGRectMake(45,0,10,10)
  end
  it "top should be in the right position before reapply" do
    @subject.get(:top_right).frame.should == CGRectMake(90,0,10,10)
  end
  it "top should be in the right position before reapply" do
    @subject.get(:left).frame.should == CGRectMake(0,45,10,10)
  end
  it "top should be in the right position before reapply" do
    @subject.get(:center).frame.should == CGRectMake(45,45,10,10)
  end
  it "top should be in the right position before reapply" do
    @subject.get(:right).frame.should == CGRectMake(90,45,10,10)
  end
  it "top should be in the right position before reapply" do
    @subject.get(:bottom_left).frame.should == CGRectMake(0,90,10,10)
  end

  it "top should be in the right position before reapply" do
    @subject.get(:bottom).frame.should == CGRectMake(45,90,10,10)
  end

  it "top should be in the right position before reapply" do
    @subject.get(:bottom_right).frame.should == CGRectMake(90,90,10,10)
  end

  it "reapplies the frames" do
    @subject.reapply!
    1.should == 1
  end

  it "top_left should be in the right position after reapply" do
    @subject.get(:top_left).frame.should == CGRectMake(0,0,10,10)
  end

  it "top should be in the right position after reapply" do
    @subject.get(:top).frame.should == CGRectMake(45,0,10,10)
  end
  it "top should be in the right position after reapply" do
    @subject.get(:top_right).frame.should == CGRectMake(90,0,10,10)
  end
  it "top should be in the right position after reapply" do
    @subject.get(:left).frame.should == CGRectMake(0,45,10,10)
  end
  it "top should be in the right position after reapply" do
    @subject.get(:center).frame.should == CGRectMake(45,45,10,10)
  end
  it "top should be in the right position after reapply" do
    @subject.get(:right).frame.should == CGRectMake(90,45,10,10)
  end
  it "top should be in the right position after reapply" do
    @subject.get(:bottom_left).frame.should == CGRectMake(0,90,10,10)
  end

  it "top should be in the right position after reapply" do
    @subject.get(:bottom).frame.should == CGRectMake(45,90,10,10)
  end

  it "top should be in the right position after reapply" do
    @subject.get(:bottom_right).frame.should == CGRectMake(90,90,10,10)
  end

end

