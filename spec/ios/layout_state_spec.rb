describe 'Blocks that are state specific' do

  before do
    @subject = TestLayoutState.new
  end

  it 'should run the initial blocks from layout' do
    @subject.view.text.should == 'initial'
  end

  it 'should run the reapply blocks from layout' do
    @subject.reapply!
    @subject.view.text.should == 'reapply'
  end

  it 'should run the initial blocks from any method' do
    any_view = @subject.any_view
    any_view.text.should == 'initial'
  end

  it 'should run the reapply blocks from any method' do
    any_view = @subject.any_view
    @subject.reapply!
    any_view.text.should == 'reapply'
  end

end