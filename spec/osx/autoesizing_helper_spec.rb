describe 'Autoresize helpers' do

  before do
    @layout = MK::Layout.new
    @view = NSView.alloc.initWithFrame([[0, 0], [10, 10]])
  end

  it 'should support :flexible_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_left
    end
    mask.should == NSViewMinXMargin
  end

  it 'should support :flexible_width' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_width
    end
    mask.should == NSViewWidthSizable
  end

  it 'should support :flexible_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_right
    end
    mask.should == NSViewMaxXMargin
  end

  it 'should support :flexible_top' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_top
    end
    mask.should == NSViewMaxYMargin
  end

  it 'should support :flexible_height' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_height
    end
    mask.should == NSViewHeightSizable
  end

  it 'should support :flexible_bottom' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :flexible_bottom
    end
    mask.should == NSViewMinYMargin
  end

  it 'should support :fill' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill
    end
    mask.should == NSViewWidthSizable | NSViewHeightSizable
  end

  it 'should support :fill_top' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_top
    end
    mask.should == NSViewWidthSizable | NSViewMinYMargin
  end

  it 'should support :fill_bottom' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_bottom
    end
    mask.should == NSViewWidthSizable | NSViewMaxYMargin
  end

  it 'should support :fill_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_left
    end
    mask.should == NSViewHeightSizable | NSViewMaxXMargin
  end

  it 'should support :fill_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :fill_right
    end
    mask.should == NSViewHeightSizable | NSViewMinXMargin
  end

  it 'should support :pin_to_top_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_top_left
    end
    mask.should == NSViewMaxXMargin | NSViewMinYMargin
  end

  it 'should support :pin_to_top' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_top
    end
    mask.should == NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin
  end

  it 'should support :pin_to_top_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_top_right
    end
    mask.should == NSViewMinXMargin | NSViewMinYMargin
  end

  it 'should support :pin_to_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_left
    end
    mask.should == NSViewMaxYMargin | NSViewMinYMargin | NSViewMaxXMargin
  end

  it 'should support :pin_to_center' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_center
    end
    mask.should == NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin | NSViewMaxXMargin
  end

  it 'should support :pin_to_middle' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_middle
    end
    mask.should == NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin | NSViewMaxXMargin
  end

  it 'should support :pin_to_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_right
    end
    mask.should == NSViewMaxYMargin | NSViewMinYMargin | NSViewMinXMargin
  end

  it 'should support :pin_to_bottom_left' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_bottom_left
    end
    mask.should == NSViewMaxXMargin | NSViewMaxYMargin
  end

  it 'should support :pin_to_bottom' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_bottom
    end
    mask.should == NSViewMinXMargin | NSViewMaxXMargin | NSViewMaxYMargin
  end

  it 'should support :pin_to_bottom_right' do
    mask = nil
    @layout.context(@view) do
      mask = @layout.autoresizing_mask :pin_to_bottom_right
    end
    mask.should == NSViewMinXMargin | NSViewMaxYMargin
  end

end
