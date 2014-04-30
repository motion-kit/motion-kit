describe 'Constraints helpers' do

  before do
    @layout = MK::Layout.new
    @constraint = nil
  end

  describe '`x/left` support' do
    it 'should support `x 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :left
    end
    it 'should support `min_x 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :left
    end
    it 'should support `max_x 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :left
    end
    it 'should support `x.equals(:view[, :left])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.x.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `min_x.equals(:view[, :left])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `max_x.equals(:view[, :left])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `x.equals(:view, :right)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.x.equals(:view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `min_x.equals(:view, :right)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `max_x.equals(:view, :right)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `x.equals(:view, :right).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.x.equals(:view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `min_x.equals(:view, :right).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `max_x.equals(:view, :right).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `x.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.x.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `min_x.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_x.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `max_x.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_x.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `left.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.left.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `min_left.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_left.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `max_left.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_left.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
  end

  describe '`center_x` support' do
    it 'should support `center_x 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :center_x
    end
    it 'should support `min_center_x 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :center_x
    end
    it 'should support `max_center_x 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_x(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :center_x
    end
    it 'should support `center_x.equals(:view[, :center_x])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_x
    end
    it 'should support `min_center_x.equals(:view[, :center_x])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_x
    end
    it 'should support `max_center_x.equals(:view[, :center_x])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_x
    end
    it 'should support `center_x.equals(:view, :right)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `min_center_x.equals(:view, :right)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `max_center_x.equals(:view, :right)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:view, :right)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `center_x.equals(:view, :right).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `min_center_x.equals(:view, :right).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `max_center_x.equals(:view, :right).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:view, :right).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `center_x.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_x.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_x
    end
    it 'should support `min_center_x.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_x.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_x
    end
    it 'should support `max_center_x.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_x.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_x
    end
  end

  describe '`right` support' do
    it 'should support `right 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.right(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :right
    end
    it 'should support `min_right 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_right(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :right
    end
    it 'should support `max_right 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_right(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :right
    end
    it 'should support `right.equals(:view[, :right])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.right.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `min_right.equals(:view[, :right])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `max_right.equals(:view[, :right])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `right.equals(:view, :left)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.right.equals(:view, :left)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `min_right.equals(:view, :left)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:view, :left)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `max_right.equals(:view, :left)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:view, :left)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `right.equals(:view, :left).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.right.equals(:view, :left).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `min_right.equals(:view, :left).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:view, :left).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `max_right.equals(:view, :left).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:view, :left).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :left
    end
    it 'should support `right.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.right.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `min_right.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_right.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
    it 'should support `max_right.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_right.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :right
    end
  end

  describe '`y/top` support' do
    it 'should support `y 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :top
    end
    it 'should support `min_y 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :top
    end
    it 'should support `max_y 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :top
    end
    it 'should support `y.equals(:view[, :top])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.y.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `min_y.equals(:view[, :top])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `max_y.equals(:view[, :top])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `y.equals(:view, :bottom)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.y.equals(:view, :bottom)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_y.equals(:view, :bottom)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:view, :bottom)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_y.equals(:view, :bottom)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:view, :bottom)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `y.equals(:view, :bottom).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.y.equals(:view, :bottom).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_y.equals(:view, :bottom).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:view, :bottom).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_y.equals(:view, :bottom).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:view, :bottom).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `y.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.y.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `min_y.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_y.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `max_y.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_y.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `top.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.top.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `min_top.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_top.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `max_top.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_top.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
  end

  describe '`center_y` support' do
    it 'should support `center_y 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :center_y
    end
    it 'should support `min_center_y 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :center_y
    end
    it 'should support `max_center_y 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_y(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :center_y
    end
    it 'should support `center_y.equals(:view[, :center_y])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_y
    end
    it 'should support `min_center_y.equals(:view[, :center_y])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_y
    end
    it 'should support `max_center_y.equals(:view[, :center_y])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_y
    end
    it 'should support `center_y.equals(:view, :top)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `min_center_y.equals(:view, :top)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `max_center_y.equals(:view, :top)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `center_y.equals(:view, :top).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `min_center_y.equals(:view, :top).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `max_center_y.equals(:view, :top).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `center_y.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.center_y.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_y
    end
    it 'should support `min_center_y.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_center_y.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_y
    end
    it 'should support `max_center_y.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_center_y.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :center_y
    end
  end

  describe '`bottom` support' do
    it 'should support `bottom 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.bottom(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_bottom 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_bottom(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_bottom 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_bottom(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :bottom
    end
    it 'should support `bottom.equals(:view[, :bottom])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_bottom.equals(:view[, :bottom])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_bottom.equals(:view[, :bottom])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `bottom.equals(:view, :top)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `min_bottom.equals(:view, :top)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `max_bottom.equals(:view, :top)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:view, :top)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `bottom.equals(:view, :top).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `min_bottom.equals(:view, :top).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `max_bottom.equals(:view, :top).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:view, :top).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :top
    end
    it 'should support `bottom.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.bottom.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `min_bottom.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_bottom.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
    it 'should support `max_bottom.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_bottom.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :bottom
    end
  end

  describe '`width` support' do
    it 'should support `width 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.width(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :width
    end
    it 'should support `min_width 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_width(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :width
    end
    it 'should support `max_width 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_width(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :width
    end
    it 'should support `width.equals(:view[, :width])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.width.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :width
    end
    it 'should support `min_width.equals(:view[, :width])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_width.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :width
    end
    it 'should support `max_width.equals(:view[, :width])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_width.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :width
    end
    it 'should support `width.equals(:view, :height).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.width.equals(:view, :height).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `min_width.equals(:view, :height).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_width.equals(:view, :height).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `max_width.equals(:view, :height).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_width.equals(:view, :height).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `width.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.width.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :width
    end
    it 'should support `min_width.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_width.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :width
    end
    it 'should support `max_width.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_width.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :width
    end
  end

  describe '`height` support' do
    it 'should support `height 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.height(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_height(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height 10`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_height(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == nil
      @constraint.attribute2.should == :height
    end
    it 'should support `height.equals(:view[, :height])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.height.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height.equals(:view[, :height])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_height.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height.equals(:view[, :height])`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_height.equals(:view)
        end
      end
      @constraint.constant.should == 0
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `height.equals(:view).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.height.equals(:view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height.equals(:view).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_height.equals(:view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height.equals(:view).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_height.equals(:view).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 1
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `height.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.height.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :equal
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `min_height.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.min_height.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :gte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
    it 'should support `max_height.equals(:view).times(2).plus(10)`' do
      @layout.context(NSView.new) do
        @layout.constraints do
          @constraint = @layout.max_height.equals(:view).times(2).plus(10)
        end
      end
      @constraint.constant.should == 10
      @constraint.relationship.should == :lte
      @constraint.multiplier.should == 2
      @constraint.relative_to.should == :view
      @constraint.attribute2.should == :height
    end
  end

end
