describe 'Constraints helpers' do

  before do
    @parent_view = NSView.new
    @layout = MK::Layout.new(root: @parent_view)
    @view = NSView.new
    @parent_view.addSubview(@view)
    @another_view = NSView.new
    @layout.context(@parent_view) do
      @layout.add(@another_view, :another_view)
    end
    @constraint = nil
  end

  describe '`x/left` support' do
    it 'should support `x 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `min_x 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `max_x 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `x.equals(:another_view[, :left])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.x.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `x.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.x.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `x.equals(:another_view).plus(10).plus(20)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.x.equals(:another_view).plus(10).plus(20)
        end
      end
      @constraint.constant.should == 30
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `min_x.equals(:another_view[, :left])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `max_x.equals(:another_view[, :left])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `x.equals(:another_view, :right)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.x.equals(:another_view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :right
    end
    it 'should support `min_x.equals(:another_view, :right)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:another_view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :right
    end
    it 'should support `max_x.equals(:another_view, :right)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:another_view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :right
    end
    it 'should support `x.equals(:another_view, :right).minus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.x.equals(:another_view, :right).minus(10)
        end
      end
      @constraint.constant.should == -10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :right
    end
    it 'should support `min_x.equals(:another_view, :right).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:another_view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :right
    end
    it 'should support `max_x.equals(:another_view, :right).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:another_view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :right
    end
    it 'should support `x.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.x.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `min_x.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `max_x.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `left.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.left.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `min_left.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_left.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
    it 'should support `max_left.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_left.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :left
      @constraint.attribute2.should == :left
    end
  end

  describe '`center_x` support' do
    it 'should support `center_x 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `min_center_x 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `max_center_x 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `center_x.equals(:another_view[, :center_x])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `min_center_x.equals(:another_view[, :center_x])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `max_center_x.equals(:another_view[, :center_x])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `center_x.equals(:another_view, :right)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:another_view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :right
    end
    it 'should support `min_center_x.equals(:another_view, :right)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:another_view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :right
    end
    it 'should support `max_center_x.equals(:another_view, :right)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:another_view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :right
    end
    it 'should support `center_x.equals(:another_view, :right).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:another_view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :right
    end
    it 'should support `min_center_x.equals(:another_view, :right).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:another_view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :right
    end
    it 'should support `max_center_x.equals(:another_view, :right).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:another_view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :right
    end
    it 'should support `center_x.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `min_center_x.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
    it 'should support `max_center_x.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_x
      @constraint.attribute2.should == :center_x
    end
  end

  describe '`right` support' do
    it 'should support `right 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.right(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `min_right 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_right(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `max_right 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_right(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `right.equals(:another_view[, :right])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.right.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `min_right.equals(:another_view[, :right])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `max_right.equals(:another_view[, :right])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `right.equals(:another_view, :left)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.right.equals(:another_view, :left)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :left
    end
    it 'should support `min_right.equals(:another_view, :left)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:another_view, :left)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :left
    end
    it 'should support `max_right.equals(:another_view, :left)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:another_view, :left)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :left
    end
    it 'should support `right.equals(:another_view, :left).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.right.equals(:another_view, :left).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :left
    end
    it 'should support `min_right.equals(:another_view, :left).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:another_view, :left).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :left
    end
    it 'should support `max_right.equals(:another_view, :left).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:another_view, :left).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :left
    end
    it 'should support `right.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.right.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `min_right.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
    it 'should support `max_right.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :right
      @constraint.attribute2.should == :right
    end
  end

  describe '`y/top` support' do
    it 'should support `y 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `min_y 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `max_y 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `y.equals(:another_view[, :top])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.y.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `min_y.equals(:another_view[, :top])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `max_y.equals(:another_view[, :top])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `y.equals(:another_view, :bottom)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.y.equals(:another_view, :bottom)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_y.equals(:another_view, :bottom)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:another_view, :bottom)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_y.equals(:another_view, :bottom)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:another_view, :bottom)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :bottom
    end
    it 'should support `y.equals(:another_view, :bottom).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.y.equals(:another_view, :bottom).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_y.equals(:another_view, :bottom).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:another_view, :bottom).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_y.equals(:another_view, :bottom).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:another_view, :bottom).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :bottom
    end
    it 'should support `y.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.y.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `min_y.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `max_y.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `top.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.top.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `min_top.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_top.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
    it 'should support `max_top.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_top.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :top
      @constraint.attribute2.should == :top
    end
  end

  describe '`center_y` support' do
    it 'should support `center_y 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `min_center_y 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `max_center_y 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `center_y.equals(:another_view[, :center_y])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `min_center_y.equals(:another_view[, :center_y])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `max_center_y.equals(:another_view[, :center_y])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `center_y.equals(:another_view, :top)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:another_view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :top
    end
    it 'should support `min_center_y.equals(:another_view, :top)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:another_view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :top
    end
    it 'should support `max_center_y.equals(:another_view, :top)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:another_view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :top
    end
    it 'should support `center_y.equals(:another_view, :top).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:another_view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :top
    end
    it 'should support `min_center_y.equals(:another_view, :top).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:another_view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :top
    end
    it 'should support `max_center_y.equals(:another_view, :top).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:another_view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :top
    end
    it 'should support `center_y.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `min_center_y.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
    it 'should support `max_center_y.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :center_y
      @constraint.attribute2.should == :center_y
    end
  end

  describe '`bottom` support' do
    it 'should support `bottom 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.bottom(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_bottom 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_bottom(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_bottom 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_bottom(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `bottom.equals(:another_view[, :bottom])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_bottom.equals(:another_view[, :bottom])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_bottom.equals(:another_view[, :bottom])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `bottom.equals(:another_view, :top)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:another_view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :top
    end
    it 'should support `min_bottom.equals(:another_view, :top)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:another_view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :top
    end
    it 'should support `max_bottom.equals(:another_view, :top)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:another_view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :top
    end
    it 'should support `bottom.equals(:another_view, :top).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:another_view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :top
    end
    it 'should support `min_bottom.equals(:another_view, :top).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:another_view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :top
    end
    it 'should support `max_bottom.equals(:another_view, :top).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:another_view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :top
    end
    it 'should support `bottom.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_bottom.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_bottom.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :bottom
      @constraint.attribute2.should == :bottom
    end
  end

  describe '`width` support' do
    it 'should support `width 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.width(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `min_width 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_width(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `max_width 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_width(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `width.equals(:another_view[, :width])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.width.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `min_width.equals(:another_view[, :width])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_width.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `max_width.equals(:another_view[, :width])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_width.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `width.equals(:another_view, :height).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.width.equals(:another_view, :height).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :height
    end
    it 'should support `min_width.equals(:another_view, :height).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_width.equals(:another_view, :height).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :height
    end
    it 'should support `max_width.equals(:another_view, :height).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_width.equals(:another_view, :height).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :height
    end
    it 'should support `width.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.width.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `min_width.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_width.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
    it 'should support `max_width.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_width.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :width
      @constraint.attribute2.should == :width
    end
  end

  describe '`height` support' do
    it 'should support `height 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.height(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_height(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_height(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `height.equals(:another_view[, :height])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.height.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height.equals(:another_view[, :height])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_height.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height.equals(:another_view[, :height])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_height.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `height.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.height.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_height.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_height.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `height.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.height.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_height.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_height.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :height
      @constraint.attribute2.should == :height
    end
  end

  describe '`leading` support' do
    it 'should support `leading 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.leading(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `min_leading 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_leading(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `max_leading 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_leading(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `leading.equals(:another_view[, :leading])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.leading.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `min_leading.equals(:another_view[, :leading])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_leading.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `max_leading.equals(:another_view[, :leading])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_leading.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `leading.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.leading.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `min_leading.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_leading.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `max_leading.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_leading.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `leading.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.leading.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `min_leading.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_leading.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
    it 'should support `max_leading.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_leading.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :leading
      @constraint.attribute2.should == :leading
    end
  end

  describe '`trailing` support' do
    it 'should support `trailing 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.trailing(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `min_trailing 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_trailing(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `max_trailing 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_trailing(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `trailing.equals(:another_view[, :trailing])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.trailing.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `min_trailing.equals(:another_view[, :trailing])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_trailing.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `max_trailing.equals(:another_view[, :trailing])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_trailing.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `trailing.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.trailing.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `min_trailing.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_trailing.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `max_trailing.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_trailing.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `trailing.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.trailing.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `min_trailing.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_trailing.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
    it 'should support `max_trailing.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_trailing.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :trailing
      @constraint.attribute2.should == :trailing
    end
  end

  describe '`baseline` support' do
    it 'should support `baseline 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.baseline(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `min_baseline 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_baseline(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `max_baseline 10`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_baseline(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :superview
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `baseline.equals(:another_view[, :baseline])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.baseline.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `min_baseline.equals(:another_view[, :baseline])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_baseline.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `max_baseline.equals(:another_view[, :baseline])`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_baseline.equals(:another_view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `baseline.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.baseline.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `min_baseline.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_baseline.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `max_baseline.equals(:another_view).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_baseline.equals(:another_view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `baseline.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.baseline.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `min_baseline.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.min_baseline.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
    it 'should support `max_baseline.equals(:another_view).times(2).plus(10)`' do
      @layout.context(@view) do
        @layout.constraints do
          @constraint = @layout.max_baseline.equals(:another_view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :another_view
      @constraint.attribute.should == :baseline
      @constraint.attribute2.should == :baseline
    end
  end

end
