describe 'Constraints - attribute lookup' do

  it 'should return NSLayoutAttributeLeft' do
    MotionKit::Constraint.attribute_lookup(:left).should == NSLayoutAttributeLeft
    MotionKit::Constraint.attribute_lookup(NSLayoutAttributeLeft).should == NSLayoutAttributeLeft
  end

  it 'should return NSLayoutAttributeWidth' do
    MotionKit::Constraint.attribute_lookup(:width).should == NSLayoutAttributeWidth
    MotionKit::Constraint.attribute_lookup(NSLayoutAttributeWidth).should == NSLayoutAttributeWidth
  end

  it 'should raise InvalidAttributeError' do
    -> do
      MotionKit::Constraint.attribute_lookup(:foo)
    end.should.raise(MotionKit::InvalidAttributeError)
  end

  it 'should reverse NSLayoutAttributeLeft' do
    MotionKit::Constraint.attribute_reverse(NSLayoutAttributeLeft).should == :left
  end

  it 'should reverse NSLayoutAttributeWidth' do
    MotionKit::Constraint.attribute_reverse(NSLayoutAttributeWidth).should == :width
  end

end
