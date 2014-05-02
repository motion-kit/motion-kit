describe 'Constraints - relationship lookup' do

  it 'should return NSLayoutRelationEqual' do
    MotionKit::Constraint.relationship_lookup(:equal).should == NSLayoutRelationEqual
    MotionKit::Constraint.relationship_lookup(NSLayoutRelationEqual).should == NSLayoutRelationEqual
  end

  it 'should return NSLayoutRelationGreaterThanOrEqual' do
    MotionKit::Constraint.relationship_lookup(:gte).should == NSLayoutRelationGreaterThanOrEqual
    MotionKit::Constraint.relationship_lookup(NSLayoutRelationGreaterThanOrEqual).should == NSLayoutRelationGreaterThanOrEqual
  end

  it 'should raise InvalidRelationshipError' do
    -> do
      MotionKit::Constraint.relationship_lookup(:foo)
    end.should.raise(MotionKit::InvalidRelationshipError)
  end

  it 'should reverse NSLayoutRelationEqual' do
    MotionKit::Constraint.relationship_reverse(NSLayoutRelationEqual).should == :equal
  end

  it 'should reverse NSLayoutRelationGreaterThanOrEqual' do
    MotionKit::Constraint.relationship_reverse(NSLayoutRelationGreaterThanOrEqual).should == :gte
  end

end
