describe 'Constraints - axis lookup' do

  it 'should return UILayoutConstraintAxisHorizontal' do
    MotionKit::Constraint.axis_lookup(:horizontal).should == UILayoutConstraintAxisHorizontal
    MotionKit::Constraint.axis_lookup(UILayoutConstraintAxisHorizontal).should == UILayoutConstraintAxisHorizontal
  end

  it 'should return UILayoutConstraintAxisVertical' do
    MotionKit::Constraint.axis_lookup(:vertical).should == UILayoutConstraintAxisVertical
    MotionKit::Constraint.axis_lookup(UILayoutConstraintAxisVertical).should == UILayoutConstraintAxisVertical
  end

end
