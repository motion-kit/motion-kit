class MagicSizeView < UIView

  def intrinsicContentSize
    CGSize.new(200, 100)
  end

end


describe 'Constraints - Size helpers' do

  before do
    @layout = MK::Layout.new
    @constraint = nil
    @view = MagicSizeView.new
  end

  it 'should support `height :scale`' do
    @layout.context(@view) do
      @layout.constraints do
        @constraint = @layout.height(:scale)
      end
    end

    @constraint.target.should == @view
    @constraint.attribute.should == :height
    @constraint.attribute2.should == :width
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 0.5
    nsconstraint = @constraint.resolve_all(@layout, @view).first
    nsconstraint.firstItem.should == @view
    nsconstraint.firstAttribute.should == NSLayoutAttributeHeight
    nsconstraint.secondItem.should == @view
    nsconstraint.secondAttribute.should == NSLayoutAttributeWidth
    nsconstraint.relation.should == NSLayoutRelationEqual
    nsconstraint.multiplier.should == 0.5
    nsconstraint.constant.should == 0
  end

  it 'should support `width :scale`' do
    @layout.context(@view) do
      @layout.constraints do
        @constraint = @layout.width(:scale)
      end
    end

    @constraint.target.should == @view
    @constraint.attribute.should == :width
    @constraint.attribute2.should == :height
    @constraint.relationship.should == :equal
    @constraint.multiplier.should == 2.0
    nsconstraint = @constraint.resolve_all(@layout, @view).first
    nsconstraint.firstItem.should == @view
    nsconstraint.firstAttribute.should == NSLayoutAttributeWidth
    nsconstraint.secondItem.should == @view
    nsconstraint.secondAttribute.should == NSLayoutAttributeHeight
    nsconstraint.relation.should == NSLayoutRelationEqual
    nsconstraint.multiplier.should == 2.0
    nsconstraint.constant.should == 0
  end

end
