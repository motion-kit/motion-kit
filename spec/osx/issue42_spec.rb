# https://github.com/motion-kit/motion-kit/issues/42
describe 'Issue #42' do

  before do
    @subject = TestIssue42Layout.new
    @subject.reapply!
  end

  it 'should build' do
    @subject.window.should.be.kind_of(NSWindow)
  end

  it 'should have a cancel_button' do
    @subject.get(:cancel_button).should.be.kind_of(NSButton)
  end

  it 'should have a ok_button' do
    @subject.get(:ok_button).should.be.kind_of(NSButton)
  end

end
