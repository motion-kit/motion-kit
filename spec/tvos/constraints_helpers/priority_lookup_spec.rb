describe 'Constraints - priority lookup' do

  it 'should return 1000' do
    MotionKit::Constraint.priority_lookup(:required).should == 1000
    MotionKit::Constraint.priority_lookup(1000).should == 1000
  end

  it 'should return 250' do
    MotionKit::Constraint.priority_lookup(:low).should == 250
    MotionKit::Constraint.priority_lookup(250).should == 250
  end

  it 'should raise InvalidPriorityError' do
    -> do
      MotionKit::Constraint.priority_lookup(:foo)
    end.should.raise(MotionKit::InvalidPriorityError)
  end

end
