describe 'Frame helpers' do

  before do
    @layout = MK::Layout.new
    @view = UIView.alloc.initWithFrame([[0, 0], [1, 1]])
    @superview_size = CGSize.new(33, 44)
    @superview = UIView.alloc.initWithFrame([[11, 22], @superview_size])
    @superview.addSubview(@view)
  end

  it 'should support `x` method' do
    @layout.context(@view) do
      retval = @layout.x 1
      @view.frame.origin.x.should == 1
      retval.should == CGRectGetMinX(@view.frame)

      retval = @layout.x '100% - 1'
      @view.frame.origin.x.should == @superview_size.width - 1
      retval.should == CGRectGetMinX(@view.frame)
    end
  end

  it 'should support `left` method' do
    @layout.context(@view) do
      retval = @layout.left 1
      @view.frame.origin.x.should == 1
      retval.should == CGRectGetMinX(@view.frame)

      retval = @layout.left '100% - 1'
      @view.frame.origin.x.should == @superview_size.width - 1
      retval.should == CGRectGetMinX(@view.frame)
    end
  end

  it 'should support `right` method' do
    @layout.context(@view) do
      retval = @layout.right 1
      @view.frame.origin.x.should == 1 - @view.frame.size.width
      retval.should == CGRectGetMaxX(@view.frame)

      retval = @layout.right '100% - 1'
      @view.frame.origin.x.should == @superview_size.width - 1 - @view.frame.size.width
      retval.should == CGRectGetMaxX(@view.frame)
    end
  end

  it 'should support `center_x` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center_x 1
      @view.frame.origin.x.should == 0
      retval.should == CGRectGetMidX(@view.frame)

      retval = @layout.center_x '100% - 1'
      @view.frame.origin.x.should == @superview_size.width - 2
      retval.should == CGRectGetMidX(@view.frame)
    end
  end

  it 'should support `middle_x` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.middle_x 1
      @view.frame.origin.x.should == 0
      retval.should == CGRectGetMidX(@view.frame)

      retval = @layout.middle_x '100% - 1'
      @view.frame.origin.x.should == @superview_size.width - 2
      retval.should == CGRectGetMidX(@view.frame)
    end
  end

  it 'should support `y` method' do
    @layout.context(@view) do
      retval = @layout.y 1
      @view.frame.origin.y.should == 1
      retval.should == CGRectGetMinY(@view.frame)

      retval = @layout.y '100% - 1'
      @view.frame.origin.y.should == @superview_size.height - 1
      retval.should == CGRectGetMinY(@view.frame)
    end
  end

  it 'should support `top` method' do
    @layout.context(@view) do
      retval = @layout.top 1
      @view.frame.origin.y.should == 1
      retval.should == CGRectGetMinY(@view.frame)

      retval = @layout.top '100% - 1'
      @view.frame.origin.y.should == @superview_size.height - 1
      retval.should == CGRectGetMinY(@view.frame)
    end
  end

  it 'should support `bottom` method' do
    @layout.context(@view) do
      retval = @layout.bottom 1
      @view.frame.origin.y.should == 1 - @view.frame.size.height
      retval.should == CGRectGetMaxY(@view.frame)

      retval = @layout.bottom '100% - 1'
      @view.frame.origin.y.should == @superview_size.height - 1 - @view.frame.size.height
      retval.should == CGRectGetMaxY(@view.frame)
    end
  end

  it 'should support `center_y` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center_y 1
      @view.frame.origin.y.should == 0
      retval.should == CGRectGetMidY(@view.frame)

      retval = @layout.center_y '100% - 1'
      @view.frame.origin.y.should == @superview_size.height - 2
      retval.should == CGRectGetMidY(@view.frame)
    end
  end

  it 'should support `middle_y` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.middle_y 1
      @view.frame.origin.y.should == 0
      retval.should == CGRectGetMidY(@view.frame)

      retval = @layout.middle_y '100% - 1'
      @view.frame.origin.y.should == @superview_size.height - 2
      retval.should == CGRectGetMidY(@view.frame)
    end
  end

  it 'should support `width` method' do
    @layout.context(@view) do
      retval = @layout.width 1
      @view.frame.size.width.should == 1
      retval.should == CGRectGetWidth(@view.frame)

      retval = @layout.width '100% - 1'
      @view.frame.size.width.should == @superview_size.width - 1
      retval.should == CGRectGetWidth(@view.frame)
    end
  end

  it 'should support `height` method' do
    @layout.context(@view) do
      retval = @layout.height 1
      @view.frame.size.height.should == 1
      retval.should == CGRectGetHeight(@view.frame)

      retval = @layout.height '100% - 1'
      @view.frame.size.height.should == @superview_size.height - 1
      retval.should == CGRectGetHeight(@view.frame)
    end
  end

  it 'should support `origin` method' do
    @layout.context(@view) do
      retval = @layout.origin [1, 2]
      @view.frame.origin.x.should == 1
      @view.frame.origin.y.should == 2
      retval.should == @view.frame.origin

      retval = @layout.origin ['100% - 1', '100% - 2']
      @view.frame.origin.x.should == @superview_size.width - 1
      @view.frame.origin.y.should == @superview_size.height - 2
      retval.should == @view.frame.origin
    end
  end

  it 'should support `center` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center [1, 2]
      @view.frame.origin.x.should == 0
      @view.frame.origin.y.should == 1
      retval.should == @view.center

      retval = @layout.center ['100% - 1', '100% - 2']
      @view.frame.origin.x.should == @superview_size.width - 2
      @view.frame.origin.y.should == @superview_size.height - 3
      retval.should == @view.center
    end
  end

  it 'should support `size` method' do
    @layout.context(@view) do
      retval = @layout.size [1, 2]
      @view.frame.size.width.should == 1
      @view.frame.size.height.should == 2
      retval.should == @view.frame.size

      retval = @layout.size ['100% - 1', '100% - 2']
      @view.frame.size.width.should == @superview_size.width - 1
      @view.frame.size.height.should == @superview_size.height - 2
      retval.should == @view.frame.size
    end
  end

  it 'should support `size :full`' do
    @layout.context(@view) do
      retval = @layout.size :full
      retval.should == @view.frame.size
    end
    @view.frame.size.width.should == @superview_size.width
    @view.frame.size.height.should == @superview_size.height
  end

  it 'should support `size :auto`' do
    label = UILabel.alloc.init
    label.text = 'M'
    label.sizeToFit
    auto_size = label.frame.size
    label.frame = [[0, 0], [0, 0]]

    @layout.context(label) do
      retval = @layout.size :auto
      retval.should == label.frame.size
    end
    label.frame.size.width.should == auto_size.width
    label.frame.size.height.should == auto_size.height
  end

  it 'should support `size :auto, height`' do
    label = UILabel.alloc.init
    label.text = 'M'
    label.sizeToFit
    auto_size = label.frame.size
    label.frame = [[0, 0], [0, 0]]

    @layout.context(label) do
      retval = @layout.size [:auto, auto_size.height]
      retval.should == label.frame.size
    end
    label.frame.size.width.should == auto_size.width
    label.frame.size.height.should == auto_size.height
  end

  it 'should support `size width, :auto`' do
    label = UILabel.alloc.init
    label.text = 'M'
    label.sizeToFit
    auto_size = label.frame.size
    label.frame = [[0, 0], [0, 0]]

    @layout.context(label) do
      retval = @layout.size [auto_size.width, :auto]
      retval.should == label.frame.size
    end
    label.frame.size.width.should == auto_size.width
    label.frame.size.height.should == auto_size.height
  end

  it 'should support `size :scale, height`' do
    label = UILabel.alloc.init
    label.text = 'M'
    label.sizeToFit
    auto_size = label.frame.size
    label.frame = [[0, 0], [0, 0]]

    @layout.context(label) do
      retval = @layout.size [100 * auto_size.width, :scale]
      retval.should == label.frame.size
    end
    label.frame.size.width.should == 100 * auto_size.width
    label.frame.size.height.should == 100 * auto_size.height
  end

  it 'should support `size width, :scale`' do
    label = UILabel.alloc.init
    label.text = 'M'
    label.sizeToFit
    auto_size = label.frame.size
    label.frame = [[0, 0], [0, 0]]

    @layout.context(label) do
      retval = @layout.size [:scale, 100 * auto_size.height]
      retval.should == label.frame.size
    end
    label.frame.size.width.should == 100 * auto_size.width
    label.frame.size.height.should == 100 * auto_size.height
  end

  it 'should support `frame` arrays [[x, y], [w, h]]' do
    @layout.context(@view) do
      retval = @layout.frame [[1, 2], [3, 4]]
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 1
    @view.frame.origin.y.should == 2
    @view.frame.size.width.should == 3
    @view.frame.size.height.should == 4
  end

  it 'should support `frame` arrays [x, y, w, h]' do
    @layout.context(@view) do
      retval = @layout.frame [1, 2, 3, 4]
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 1
    @view.frame.origin.y.should == 2
    @view.frame.size.width.should == 3
    @view.frame.size.height.should == 4
  end

  it 'should support `frame :full`' do
    @layout.context(@view) do
      retval = @layout.frame :full
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == @superview_size.width
    @view.frame.size.height.should == @superview_size.height
  end

  it 'should support from_top_left' do
    1.should == 1
  end

  it 'should support from_top' do
    1.should == 1
  end

  it 'should support from_top_right' do
    1.should == 1
  end

  it 'should support from_left' do
    1.should == 1
  end

  it 'should support from_center' do
    1.should == 1
  end

  it 'should support from_right' do
    1.should == 1
  end

  it 'should support from_bottom_left' do
    1.should == 1
  end

  it 'should support from_bottom' do
    1.should == 1
  end

  it 'should support from_bottom_right' do
    1.should == 1
  end

  it 'should support above' do
    1.should == 1
  end

  it 'should support below' do
    1.should == 1
  end

  it 'should support before, left_of' do
    1.should == 1
  end

  it 'should support after, right_of' do
    1.should == 1
  end

  it 'should support relative_to' do
    1.should == 1
  end

end
