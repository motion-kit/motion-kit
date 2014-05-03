describe 'Constraints - Size helpers' do

  before do
    @layout = MK::Layout.new
    @constraint = nil
    @superview = nil
    @view = nil
    @another_view = nil
  end

  it 'should support `size 10`' do
    @view = @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size 10`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size 10`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size [10, 10]`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size [10, 10]`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size [10, 10]`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size w: 10, h: 10`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size(w: 10, h: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size w: 10, h: 10`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size(w: 10, h: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size w: 10, h: 10`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size(w: 10, h: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view[, :size])`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view).plus(10).plus([5, 10])`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view).plus(10).plus([5, 10])
      end
    end

    @constraint.constant.should == [15, 20]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size.equals(:another_view[, :size])`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size.equals(:another_view)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size.equals(:another_view[, :size])`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size.equals(:another_view)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size.equals(:another_view).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size.equals(:another_view).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size.equals(:another_view).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size.equals(:another_view).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view).plus([10, 10])`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view).plus([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size.equals(:another_view).plus([10, 10])`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size.equals(:another_view).plus([10, 10])
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size.equals(:another_view).plus(w: 10, h: 10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size.equals(:another_view).plus(w: 10, h: 10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [1, 1]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view).times(2).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view).times(2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size.equals(:another_view).times(2).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size.equals(:another_view).times(2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size.equals(:another_view).times(2).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size.equals(:another_view).times(2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size("50%")`' do
    @superview = @layout.context(UIView.new) do
      @view = @layout.add(UIView.new) do
        @layout.constraints do
          @constraint = @layout.max_size('50%')
        end
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [0.5, 0.5]
    @constraint.relative_to.should == nil
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size("50% + 1").of(:another_view)`' do
    @superview = @layout.context(UIView.new) do
      @view = @layout.add(UIView.new) do
        @layout.constraints do
          @constraint = @layout.max_size('50% + 1').of(:another_view)
        end
      end
    end

    @constraint.constant.should == [1, 1]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [0.5, 0.5]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view).times([2, 2]).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view).times([2, 2]).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `min_size.equals(:another_view).times([2, 2]).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.min_size.equals(:another_view).times([2, 2]).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :gte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `max_size.equals(:another_view).times(w: 2, h: 2).plus(10)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.max_size.equals(:another_view).times(w: 2, h: 2).plus(10)
      end
    end

    @constraint.constant.should == [10, 10]
    @constraint.relationship.should == :lte
    @constraint.multiplier.should == [2, 2]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view).times(2).times([3, 4])`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view).times(2).times([3, 4])
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [6, 8]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end
  it 'should support `size.equals(:another_view).divided_by(2)`' do
    @layout.context(UIView.new) do
      @layout.constraints do
        @constraint = @layout.size.equals(:another_view).divided_by(2)
      end
    end

    @constraint.constant.should == [0, 0]
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == [0.5, 0.5]
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == [:width, :height]
    @constraint.attribute2.should == [:width, :height]
  end

end
