describe "MotionKit id" do

  before do
    @layout = TestIdsLayout.new.build
  end

  it 'should have a label' do
    @layout.get(:label).should.be.kind_of UILabel
  end

  it 'should have a label with id :label' do
    @layout.get(:label).motion_kit_id.should == :label
  end

end
