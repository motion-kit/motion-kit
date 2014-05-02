describe 'Constraints - orientation lookup' do

  it 'should return NSLayoutConstraintOrientationHorizontal' do
    MotionKit::Constraint.orientation_lookup(:horizontal).should == NSLayoutConstraintOrientationHorizontal
    MotionKit::Constraint.orientation_lookup(NSLayoutConstraintOrientationHorizontal).should == NSLayoutConstraintOrientationHorizontal
  end

  it 'should return NSLayoutConstraintOrientationVertical' do
    MotionKit::Constraint.orientation_lookup(:vertical).should == NSLayoutConstraintOrientationVertical
    MotionKit::Constraint.orientation_lookup(NSLayoutConstraintOrientationVertical).should == NSLayoutConstraintOrientationVertical
  end

end
