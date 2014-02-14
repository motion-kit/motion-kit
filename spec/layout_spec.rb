describe MotionKit::Layout do
  before { @subject = TestLayout.new }

  it "should be an instance of MotionKit::Layout" do
    @subject.should.be.kind_of(MotionKit::Layout)
  end
end
