describe 'Views frames should remain unchanged' do

  before do
    @subject = ReapplyTestLayout.new
    @cw = @subject.view.frame.size.width  # container width
    @ch = @subject.view.frame.size.height # container height
  end

  it "top_left should be in the right position before and after reapply" do
    @subject.get(:top_left).frame.should == CGRectMake(0,0,10,10)
    @subject.reapply!
    @subject.get(:top_left).frame.should == CGRectMake(0,0,10,10)
  end

  it "top should be in the right position before and after reapply" do
    NSLog("top frame before reapply = #{@subject.get(:top).frame.inspect}")
    @subject.get(:top).frame.should == CGRectMake(@cw/2 - 5, 0, 10, 10)
    @subject.reapply!
    NSLog("top frame after reapply = #{@subject.get(:top).frame.inspect}")
    @subject.get(:top).frame.should == CGRectMake(@cw/2 - 5, 0, 10, 10)
  end

  it "top_right should be in the right position before and after reapply" do
    @subject.get(:top_right).frame.should == CGRectMake(@cw - 10, 0, 10, 10)
    @subject.reapply!
    @subject.get(:top_right).frame.should == CGRectMake(@cw - 10, 0, 10, 10)
  end

  it "left should be in the right position before and after reapply" do
    @subject.get(:left).frame.should == CGRectMake(0, @ch/2 - 5, 10, 10)
    @subject.reapply!
    @subject.get(:left).frame.should == CGRectMake(0, @ch/2 - 5, 10, 10)
  end

  it "center should be in the right position before and after reapply" do
    @subject.get(:center).frame.should == CGRectMake(@cw/2 - 5, @ch/2 - 5, 10, 10)
    @subject.reapply!
    @subject.get(:center).frame.should == CGRectMake(@cw/2 - 5, @ch/2 - 5, 10, 10)
  end

  it "right should be in the right position before and after reapply" do
    @subject.get(:right).frame.should == CGRectMake(@cw - 10, @ch/2 - 5, 10, 10)
    @subject.reapply!
    @subject.get(:right).frame.should == CGRectMake(@cw - 10, @ch/2 - 5, 10, 10)
  end

  it "bottom_left should be in the right position before and after reapply" do
    @subject.get(:bottom_left).frame.should == CGRectMake(0, @ch - 10, 10, 10)
    @subject.reapply!
    @subject.get(:bottom_left).frame.should == CGRectMake(0, @ch - 10, 10, 10)
  end

  it "bottom should be in the right position before and after reapply" do
    @subject.get(:bottom).frame.should == CGRectMake(@cw/2 - 5, @ch - 10, 10, 10)
    @subject.reapply!
    @subject.get(:bottom).frame.should == CGRectMake(@cw/2 - 5, @ch - 10, 10, 10)
  end

  it "bottom_right should be in the right position before and after reapply" do
    @subject.get(:bottom_right).frame.should == CGRectMake(@cw - 10, @ch - 10, 10, 10)
    @subject.reapply!
    @subject.get(:bottom_right).frame.should == CGRectMake(@cw - 10, @ch - 10, 10, 10)
  end

end

