describe 'Constraints - Center helpers' do

  before do
    @layout = MK::Layout.new
    @constraint = nil
    @view = nil
    @another_view = nil
  end

  it 'should support `center [10, 10]`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.center([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeCenterX
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == nil
    resolved[0].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeCenterY
    resolved[1].relation.should == NSLayoutRelationEqual
    resolved[1].secondItem.should == nil
    resolved[1].secondAttribute.should == NSLayoutAttributeNotAnAttribute
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 10
  end
  it 'should support `min_center [10, 10]`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_center([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `max_center [10, 10]`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_center([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center x: 10, y: 10`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.center(x: 10, y: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `min_center x: 10, y: 10`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_center(x: 10, y: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `max_center x: 10, y: 10`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_center(x: 10, y: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center.equals(:another_view[, :center])`' do
    @top = @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center.equals(:another_view).plus(10).plus([5, 10])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view).plus(10).plus([5, 10])
      end
    end

    @constraint.constant.should == [15, 20]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `min_center.equals(:another_view[, :center])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.min_center.equals(:another_view)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeCenterX
    resolved[0].relation.should == NSLayoutRelationGreaterThanOrEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeCenterX
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeCenterY
    resolved[1].relation.should == NSLayoutRelationGreaterThanOrEqual
    resolved[1].secondItem.should == @another_view
    resolved[1].secondAttribute.should == NSLayoutAttributeCenterY
    resolved[1].multiplier.should == 1
    resolved[1].constant.should == 0
  end
  it 'should support `max_center.equals(:another_view[, :center])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.max_center.equals(:another_view)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center.equals(:another_view).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `min_center.equals(:another_view).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.min_center.equals(:another_view).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `max_center.equals(:another_view).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.max_center.equals(:another_view).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center.equals(:another_view).plus([10, 10])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view).plus([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `min_center.equals(:another_view).plus([10, 10])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.min_center.equals(:another_view).plus([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `max_center.equals(:another_view).plus(x: 10, y: 10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.max_center.equals(:another_view).plus(x: 10, y: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center.equals(:another_view).times(2).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view).times(2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `min_center.equals(:another_view).times(2).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.min_center.equals(:another_view).times(2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `max_center.equals(:another_view).times(2).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.max_center.equals(:another_view).times(2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 2
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeCenterX
    resolved[0].relation.should == NSLayoutRelationLessThanOrEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeCenterX
    resolved[0].multiplier.should == 2
    resolved[0].constant.should == 10

    resolved[1].firstItem.should == @view
    resolved[1].firstAttribute.should == NSLayoutAttributeCenterY
    resolved[1].relation.should == NSLayoutRelationLessThanOrEqual
    resolved[1].secondItem.should == @another_view
    resolved[1].secondAttribute.should == NSLayoutAttributeCenterY
    resolved[1].multiplier.should == 2
    resolved[1].constant.should == 10
  end
  it 'should support `center.equals(:another_view).times([2, 2]).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view).times([2, 2]).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `min_center.equals(:another_view).times([2, 2]).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.min_center.equals(:another_view).times([2, 2]).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `max_center.equals(:another_view).times(x: 2, y: 2).plus(10)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.max_center.equals(:another_view).times(x: 2, y: 2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center.equals(:another_view).times(2).times([3, 4])`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view).times(2).times([3, 4])
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [6, 8]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end
  it 'should support `center.equals(:another_view).divided_by(2)`' do
    @view = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @layout.constraints do
        @constraint = @layout.center.equals(:another_view).divided_by(2)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [0.5, 0.5]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:center_x, :center_y]
    @constraint.attribute2.should == [:center_x, :center_y]
  end

end
