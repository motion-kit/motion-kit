describe 'Constraints - view_lookup method' do

  before do
    @layout = MK::Layout.new
    @constraint = nil
    @view = nil
    @another_view = nil
  end

  it 'should support :superview' do
    @superview = @layout.context(UIView.new) do
      @view = @layout.add(UIView.new) do
        @layout.constraints do
          @constraint = @layout.left.equals(:superview).plus(10)
        end
      end
    end

    @constraint.constant.should == 10
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 1
    @constraint.relative_to.should == :superview
    @constraint.attribute.should == :left
    @constraint.attribute2.should == :left

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should.be.kind_of(UIView)
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @superview
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10
  end

  it 'should support :another_view' do
    @superview = @layout.context(UIView.new) do
      @view = @layout.add(UIView.new) do
        @layout.constraints do
          @constraint = @layout.left.equals(:another_view).plus(10)
        end
      end
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
    end

    @constraint.constant.should == 10
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 1
    @constraint.relative_to.should == :another_view
    @constraint.attribute.should == :left
    @constraint.attribute2.should == :left

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should.be.kind_of(UIView)
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10
  end

  it 'should support @another_view' do
    @superview = @layout.context(UIView.new) do
      @another_view = @layout.add UIView.alloc.initWithFrame([[1, 1], [2, 2]]), :another_view
      @view = @layout.add(UIView.new) do
        @layout.constraints do
          @constraint = @layout.left.equals(@another_view).plus(10)
        end
      end
    end

    @constraint.constant.should == 10
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 1
    @constraint.relative_to.should == @another_view
    @constraint.attribute.should == :left
    @constraint.attribute2.should == :left

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should.be.kind_of(UIView)
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @another_view
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 10
  end

end
