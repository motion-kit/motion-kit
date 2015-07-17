describe 'Constraints - activate/deactivate helpers' do

  before do
    @layout = MotionKit::Layout.new
    @constraint = nil
    @view = UIView.new
  end

  should 'should activate/deactivate constraints' do

    @layout.context(@view) do
      @layout.constraints do
        @constraint = @layout.height(10)
      end
    end

    @view.constraints.count.should == 1
    @constraint.deactivate
    @view.constraints.count.should == 0
    @constraint.activate
    @view.constraints.count.should == 1

  end

end
