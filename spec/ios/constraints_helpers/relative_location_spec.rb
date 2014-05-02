describe 'Constraints - Relative location helpers' do

  before do
    @layout = MK::Layout.new
    @constraint = nil
    @view = nil
    @another_view = nil
  end

  it 'should support `above(:another_view)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.above(:another_view)
      end
    end

    @constraint.constant.should == 0
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 1
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == :bottom
    @constraint.attribute2.should == :top

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeBottom
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeTop
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0
  end
  it 'should support `below(:another_view)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.below(:another_view)
      end
    end

    @constraint.constant.should == 0
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 1
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == :top
    @constraint.attribute2.should == :bottom

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeTop
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeBottom
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0
  end
  it 'should support `before(:another_view)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.before(:another_view)
      end
    end

    @constraint.constant.should == 0
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 1
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == :right
    @constraint.attribute2.should == :left

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeRight
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0
  end
  it 'should support `after(:another_view)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.after(:another_view)
      end
    end

    @constraint.constant.should == 0
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 1
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == :left
    @constraint.attribute2.should == :right

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeRight
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0
  end

end
