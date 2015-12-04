describe 'Constraints - placeholder helpers' do

  before do
    @layout = MK::Layout.new
    @view = @layout.context(UIView.new) do
      @first = @layout.add UILabel.new, :label do
        @layout.text 'first'
      end
      @nth = @layout.add UILabel.new, :label do
        @layout.text 'nth'
      end
      @last = @layout.add UILabel.new, :label do
        @layout.text 'last'
      end
    end
  end

  it 'should return :first' do
    @layout.context(@view) do
      @layout.constraints do
        @constraint = @layout.x.equals(@layout.first(:label))
      end
    end

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @first
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0
  end

  it 'should return :nth' do
    @layout.context(@view) do
      @layout.constraints do
        @constraint = @layout.x.equals(@layout.nth(:label, 1))
      end
    end

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @nth
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0
  end

  it 'should return :last' do
    @layout.context(@view) do
      @layout.constraints do
        @constraint = @layout.x.equals(@layout.last(:label))
      end
    end

    resolved = @constraint.resolve_all(@layout, @view)
    resolved.length.should == 1
    resolved[0].firstItem.should == @view
    resolved[0].firstAttribute.should == NSLayoutAttributeLeft
    resolved[0].relation.should == NSLayoutRelationEqual
    resolved[0].secondItem.should == @last
    resolved[0].secondAttribute.should == NSLayoutAttributeLeft
    resolved[0].multiplier.should == 1
    resolved[0].constant.should == 0
  end

end
