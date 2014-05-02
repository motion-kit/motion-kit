describe 'Constraints - Relative corners helpers' do

  before do
    @layout = MK::Layout.new
    @constraint = nil
    @view = nil
    @another_view = nil
  end

  it 'should support `top_left [10, 10]`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.top_left([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:left, :top]
    @constraint.attribute2.should == [:left, :top]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == nil
    resolved[0].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeTop
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == nil
    resolved[1].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 10
  end
  it 'should support `top_left.equals(:another_view).plus(10).plus([5, 10])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.top_left.equals(:another_view).plus(10).plus([5, 10])
      end
    end

    @constraint.constant.should == [15, 20]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:left, :top]
    @constraint.attribute2.should == [:left, :top]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 15

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeTop
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == @another_view
    resolved[1].secondAttribute.should == NSLayoutAttributeTop
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 20
  end

  it 'should support `top_right [10, 10]`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.top_right([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:right, :top]
    @constraint.attribute2.should == [:right, :top]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeRight
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == nil
    resolved[0].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeTop
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == nil
    resolved[1].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 10
  end
  it 'should support `top_right.equals(:another_view).plus(10).plus([5, 10])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.top_right.equals(:another_view).plus(10).plus([5, 10])
      end
    end

    @constraint.constant.should == [15, 20]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:right, :top]
    @constraint.attribute2.should == [:right, :top]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeRight
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeRight
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 15

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeTop
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == @another_view
    resolved[1].secondAttribute.should == NSLayoutAttributeTop
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 20
  end

  it 'should support `bottom_left [10, 10]`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.bottom_left([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:left, :bottom]
    @constraint.attribute2.should == [:left, :bottom]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == nil
    resolved[0].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeBottom
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == nil
    resolved[1].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 10
  end
  it 'should support `bottom_left.equals(:another_view).plus(10).plus([5, 10])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.bottom_left.equals(:another_view).plus(10).plus([5, 10])
      end
    end

    @constraint.constant.should == [15, 20]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:left, :bottom]
    @constraint.attribute2.should == [:left, :bottom]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 15

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeBottom
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == @another_view
    resolved[1].secondAttribute.should == NSLayoutAttributeBottom
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 20
  end

  it 'should support `bottom_right [10, 10]`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.bottom_right([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:right, :bottom]
    @constraint.attribute2.should == [:right, :bottom]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeRight
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == nil
    resolved[0].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeBottom
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == nil
    resolved[1].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 10
  end
  it 'should support `bottom_right.equals(:another_view).plus(10).plus([5, 10])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.bottom_right.equals(:another_view).plus(10).plus([5, 10])
      end
    end

    @constraint.constant.should == [15, 20]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:right, :bottom]
    @constraint.attribute2.should == [:right, :bottom]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeRight
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeRight
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 15

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeBottom
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == @another_view
    resolved[1].secondAttribute.should == NSLayoutAttributeBottom
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 20
  end

end
