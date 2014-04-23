describe 'Autoresize helpers' do

  before do
    @layout = MK::Layout.new
    @view = UIView.alloc.initWithFrame([[0, 0], [10, 10]])
  end

  it 'should support :flexible_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_left
    end
    mask.should == UIViewAutoresizingFlexibleLeftMargin
  end

  it 'should support :flexible_width' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_width
    end
    mask.should == UIViewAutoresizingFlexibleWidth
  end

  it 'should support :flexible_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_right
    end
    mask.should == UIViewAutoresizingFlexibleRightMargin
  end

  it 'should support :flexible_top' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_top
    end
    mask.should == UIViewAutoresizingFlexibleTopMargin
  end

  it 'should support :flexible_height' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_height
    end
    mask.should == UIViewAutoresizingFlexibleHeight
  end

  it 'should support :flexible_bottom' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_bottom
    end
    mask.should == UIViewAutoresizingFlexibleBottomMargin
  end

  it 'should support :rigid_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_right, :flexible_left, :rigid_left
    end
    mask.should == UIViewAutoresizingFlexibleRightMargin
  end

  it 'should support :rigid_width' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_height, :flexible_width, :rigid_width
    end
    mask.should == UIViewAutoresizingFlexibleHeight
  end

  it 'should support :rigid_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_left, :flexible_right, :rigid_right
    end
    mask.should == UIViewAutoresizingFlexibleLeftMargin
  end

  it 'should support :rigid_top' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_bottom, :flexible_top, :rigid_top
    end
    mask.should == UIViewAutoresizingFlexibleBottomMargin
  end

  it 'should support :rigid_height' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_width, :flexible_height, :rigid_height
    end
    mask.should == UIViewAutoresizingFlexibleWidth
  end

  it 'should support :rigid_bottom' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_top, :flexible_bottom, :rigid_bottom
    end
    mask.should == UIViewAutoresizingFlexibleTopMargin
  end

  it 'should support :fill' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill
    end
    mask.should == UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
  end

  it 'should support :fill_top' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_top
    end
    mask.should == UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin
  end

  it 'should support :fill_bottom' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_bottom
    end
    mask.should == UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
  end

  it 'should support :fill_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_left
    end
    mask.should == UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin
  end

  it 'should support :fill_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_right
    end
    mask.should == UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin
  end

  it 'should support :pin_to_top_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_top_left
    end
    mask.should == UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin
  end

  it 'should support :pin_to_top' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_top
    end
    mask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin
  end

  it 'should support :pin_to_top_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_top_right
    end
    mask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin
  end

  it 'should support :pin_to_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_left
    end
    mask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin
  end

  it 'should support :pin_to_center' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_center
    end
    mask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
  end

  it 'should support :pin_to_middle' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_middle
    end
    mask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
  end

  it 'should support :pin_to_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_right
    end
    mask.should == UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin
  end

  it 'should support :pin_to_bottom_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_bottom_left
    end
    mask.should == UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
  end

  it 'should support :pin_to_bottom' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_bottom
    end
    mask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
  end

  it 'should support :pin_to_bottom_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_bottom_right
    end
    mask.should == UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin
  end

end
