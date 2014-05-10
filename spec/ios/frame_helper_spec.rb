describe 'Frame helpers' do
  tests UIViewController

  before do
    @layout = TestEmptyLayout.new
    top_view = @controller.view
    @layout.root = top_view

    @view_size = CGSize.new(8, 10)
    @view = UIView.alloc.initWithFrame([[0, 0], @view_size])
    @view.backgroundColor = UIColor.whiteColor
    @view.motion_kit_id = :view

    @superview_size = CGSize.new(60, 40)
    @superview = UIView.alloc.initWithFrame([[0, 0], @superview_size])
    @superview.addSubview(@view)
    @superview.backgroundColor = UIColor.blueColor

    @another_view = UIView.alloc.initWithFrame([[10, 100], [120, 48]])
    @another_view.backgroundColor = UIColor.redColor
    @another_view.motion_kit_id = :another_view

    top_view.addSubview(@another_view)
    top_view.addSubview(@superview)

    @label = UILabel.alloc.init
    @label.text = 'M'
    @label_auto_size = @label.intrinsicContentSize
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
      @view.frame.origin.x.should == 1 - @view_size.width
      retval.should == CGRectGetMaxX(@view.frame)

      retval = @layout.right '100% - 1'
      @view.frame.origin.x.should == @superview_size.width - 1 - @view_size.width
      retval.should == CGRectGetMaxX(@view.frame)
    end
  end

  it 'should support `center_x` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center_x 1
      @view.center.x.should == 1
      retval.should == CGRectGetMidX(@view.frame)

      retval = @layout.center_x '100% - 1'
      @view.center.x.should == @superview_size.width - 1
      retval.should == CGRectGetMidX(@view.frame)
    end
  end

  it 'should support `middle_x` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.middle_x 1
      @view.center.x.should == 1
      retval.should == CGRectGetMidX(@view.frame)

      retval = @layout.middle_x '100% - 1'
      @view.center.x.should == @superview_size.width - 1
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
      @view.frame.origin.y.should == 1 - @view_size.height
      retval.should == CGRectGetMaxY(@view.frame)

      retval = @layout.bottom '100% - 1'
      @view.frame.origin.y.should == @superview_size.height - 1 - @view_size.height
      retval.should == CGRectGetMaxY(@view.frame)
    end
  end

  it 'should support `center_y` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center_y 1
      @view.center.y.should == 1
      retval.should == CGRectGetMidY(@view.frame)

      retval = @layout.center_y '100% - 1'
      @view.center.y.should == @superview_size.height - 1
      retval.should == CGRectGetMidY(@view.frame)
    end
  end

  it 'should support `middle_y` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.middle_y 1
      @view.center.y.should == 1
      retval.should == CGRectGetMidY(@view.frame)

      retval = @layout.middle_y '100% - 1'
      @view.center.y.should == @superview_size.height - 1
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

  it 'should support `w` method' do
    @layout.context(@view) do
      retval = @layout.w 1
      @view.frame.size.width.should == 1
      retval.should == CGRectGetWidth(@view.frame)

      retval = @layout.w '100% - 1'
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

  it 'should support `h` method' do
    @layout.context(@view) do
      retval = @layout.h 1
      @view.frame.size.height.should == 1
      retval.should == CGRectGetHeight(@view.frame)

      retval = @layout.h '100% - 1'
      @view.frame.size.height.should == @superview_size.height - 1
      retval.should == CGRectGetHeight(@view.frame)
    end
  end

  it 'should support `origin([])` method' do
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

  it 'should support `origin({})` method' do
    @layout.context(@view) do
      retval = @layout.origin x: 1, y: 2
      @view.frame.origin.x.should == 1
      @view.frame.origin.y.should == 2
      retval.should == @view.frame.origin

      retval = @layout.origin x: '100% - 1', y: '100% - 2'
      @view.frame.origin.x.should == @superview_size.width - 1
      @view.frame.origin.y.should == @superview_size.height - 2
      retval.should == @view.frame.origin
    end
  end

  it 'should support `origin({relative: true})` method' do
    @layout.context(@view) do
      retval = @layout.origin right: 1, down: 2, relative: true
      @view.frame.origin.x.should == 1
      @view.frame.origin.y.should == 2
      retval.should == @view.frame.origin

      retval = @layout.origin x: '100%', y: '100%', left: 1, up: 2, relative: true
      @view.frame.origin.x.should == @superview_size.width - 1
      @view.frame.origin.y.should == @superview_size.height - 2
      retval.should == @view.frame.origin
    end
  end

  it 'should support `center([])` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center [1, 2]
      @view.center.x.should == 1
      @view.center.y.should == 2
      retval.should == @view.center

      retval = @layout.center ['100% - 1', '100% - 2']
      @view.center.x.should == @superview_size.width - 1
      @view.center.y.should == @superview_size.height - 2
      retval.should == @view.center
    end
  end

  it 'should support `center({})` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center x: 1, y: 2
      @view.center.x.should == 1
      @view.center.y.should == 2
      retval.should == @view.center

      retval = @layout.center x: '100% - 1', y: '100% - 2'
      @view.center.x.should == @superview_size.width - 1
      @view.center.y.should == @superview_size.height - 2
      retval.should == @view.center
    end
  end

  it 'should support `center({relative: true})` method' do
    @view.frame = [[0, 0], [2, 2]]
    @layout.context(@view) do
      retval = @layout.center x: 1, y: 1, right: 1, down: 2, relative: true
      @view.center.x.should == 2
      @view.center.y.should == 3
      retval.should == @view.center

      retval = @layout.center x: '100%', y: '100%', left: 1, up: 2, relative: true
      @view.center.x.should == @superview_size.width - 1
      @view.center.y.should == @superview_size.height - 2
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
    @layout.context(@label) do
      retval = @layout.size :auto
      retval.should == @label.frame.size
    end
    @label.frame.size.width.should == @label_auto_size.width
    @label.frame.size.height.should == @label_auto_size.height
  end

  it 'should support `size :auto, height`' do
    @layout.context(@label) do
      retval = @layout.size [:auto, @label_auto_size.height]
      retval.should == @label.frame.size
    end
    @label.frame.size.width.should == @label_auto_size.width
    @label.frame.size.height.should == @label_auto_size.height
  end

  it 'should support `size width, :auto`' do
    @layout.context(@label) do
      retval = @layout.size [@label_auto_size.width, :auto]
      retval.should == @label.frame.size
    end
    @label.frame.size.width.should == @label_auto_size.width
    @label.frame.size.height.should == @label_auto_size.height
  end

  it 'should support `size :scale, height`' do
    @layout.context(@label) do
      retval = @layout.size [100 * @label_auto_size.width, :scale]
      retval.should == @label.frame.size
    end
    @label.frame.size.width.should == 100 * @label_auto_size.width
    @label.frame.size.height.should == 100 * @label_auto_size.height
  end

  it 'should support `size width, :scale`' do
    @layout.context(@label) do
      retval = @layout.size [:scale, 100 * @label_auto_size.height]
      retval.should == @label.frame.size
    end
    @label.frame.size.width.should == 100 * @label_auto_size.width
    @label.frame.size.height.should == 100 * @label_auto_size.height
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

  it 'should support `frame :auto`' do
    def @view.intrinsicContentSize
      CGSize.new(1, 2)
    end

    @layout.context(@view) do
      retval = @layout.frame :auto
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == 1
    @view.frame.size.height.should == 2
  end

  it 'should support `frame :center`' do
    @layout.context(@view) do
      retval = @layout.frame :center
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 26
    @view.frame.origin.y.should == 15
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top_left`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_left()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top_left(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_left(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_top_left(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_left(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_left(right:down:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_left(right: 10, down: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_left(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_left(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top_left(:view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_left(:another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - @view_size.width) / 2
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - 10) / 2
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_top(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - 22) / 2 + 10
    @view.frame.origin.y.should == 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + (@another_view.frame.size.width - @view_size.width) / 2 + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top(view, width: "100%")`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top(@another_view, x: 1, y: 1, width: '100%')
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + (@another_view.frame.size.width - @view.frame.size.width) / 2 + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + 1
    @view.frame.size.width.should == @superview_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top_right`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_right()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - @view_size.width
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_top_right(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_right(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - 10
    @view.frame.origin.y.should == 0
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_top_right(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_right(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - 22 + 10
    @view.frame.origin.y.should == 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_right(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_top_right(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + @another_view.frame.size.width - @view_size.width + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_left`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_left()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == (@superview_size.height - @view_size.height) / 2
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_left(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_left(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == (@superview_size.height - 20) / 2
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_left(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_left(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == (@superview_size.height - 12) / 2 + 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_left(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_left(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + (@another_view.frame.size.height - @view_size.height) / 2 + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_center`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_center()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - @view_size.width) / 2
    @view.frame.origin.y.should == (@superview_size.height - @view_size.height) / 2
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_center(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_center(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - 10) / 2
    @view.frame.origin.y.should == (@superview_size.height - 20) / 2
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_center(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_center(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - 22) / 2 + 10
    @view.frame.origin.y.should == (@superview_size.height - 12) / 2 + 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_center(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_center(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + (@another_view.frame.size.width - @view_size.width) / 2 + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + (@another_view.frame.size.height - @view_size.height) / 2 + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_right`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_right()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - @view_size.width
    @view.frame.origin.y.should == (@superview_size.height - @view_size.height) / 2
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_right(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_right(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - 10
    @view.frame.origin.y.should == (@superview_size.height - 20) / 2
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_right(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_right(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - 22 + 10
    @view.frame.origin.y.should == (@superview_size.height - 12) / 2 + 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_right(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_right(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + @another_view.frame.size.width - @view_size.width + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + (@another_view.frame.size.height - @view_size.height) / 2 + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_bottom_left`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_left()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == @superview_size.height - @view_size.height
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_bottom_left(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_left(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == @superview_size.height - 20
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_bottom_left(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_left(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == @superview_size.height - 12 + 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom_left(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_left(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + @another_view.frame.size.height - @view_size.height + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_bottom`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - @view_size.width) / 2
    @view.frame.origin.y.should == @superview_size.height - @view_size.height
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_bottom(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - 10) / 2
    @view.frame.origin.y.should == @superview_size.height - 20
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_bottom(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == (@superview_size.width - 22) / 2 + 10
    @view.frame.origin.y.should == @superview_size.height - 12 + 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + (@another_view.frame.size.width - @view_size.width) / 2 + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + @another_view.frame.size.height - @view_size.height + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_bottom_right`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_right()
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - @view_size.width
    @view.frame.origin.y.should == @superview_size.height - @view_size.height
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `from_bottom_right(width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_right(width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - 10
    @view.frame.origin.y.should == @superview_size.height - 20
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_bottom_right(x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_right(x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @superview_size.width - 22 + 10
    @view.frame.origin.y.should == @superview_size.height - 12 + 20
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom_right(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.from_bottom_right(@another_view, x: 1, y: 1)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == @another_view.frame.origin.x + @another_view.frame.size.width - @view_size.width + 1
    @view.frame.origin.y.should == @another_view.frame.origin.y + @another_view.frame.size.height - @view_size.height + 1
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `above(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.above(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 90
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `above(view)` and ignore view origin' do
    f = @view.frame
    f.origin.x = 10
    f.origin.y = 10
    @view.frame = f

    @layout.context(@view) do
      retval = @layout.frame @layout.above(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 90
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `above(view, up:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.above(@another_view, up: 8)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 82
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `above(view, width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.above(@another_view, width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 80
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `above(view, x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.above(@another_view, x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 20
    @view.frame.origin.y.should == 108
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `below(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.below(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 148
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `below(view)` and ignore view origin' do
    f = @view.frame
    f.origin.x = 10
    f.origin.y = 10
    @view.frame = f

    @layout.context(@view) do
      retval = @layout.frame @layout.below(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 148
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `below(view, down:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.below(@another_view, down: 8)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 156
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `below(view, width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.below(@another_view, width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 148
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `below(view, x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.below(@another_view, x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 20
    @view.frame.origin.y.should == 168
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `before(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.before(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 2
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `before(view)` and ignore view origin' do
    f = @view.frame
    f.origin.x = 10
    f.origin.y = 10
    @view.frame = f

    @layout.context(@view) do
      retval = @layout.frame @layout.before(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 2
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `before(view, left:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.before(@another_view, left: 8)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == -6
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `before(view, width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.before(@another_view, width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 0
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `before(view, x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.before(@another_view, x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == -2
    @view.frame.origin.y.should == 120
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `left_of(view)`' do
    before = nil
    left_of = nil
    @layout.context(@view) do
      before = @layout.before(@another_view)
      left_of = @layout.left_of(@another_view)
    end
    left_of.origin.x.should == before.origin.x
    left_of.origin.y.should == before.origin.y
    left_of.size.width.should == before.size.width
    left_of.size.height.should == before.size.height
  end

  it 'should support setting the frame via `after(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.after(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 130
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `after(view)` and ignore view origin' do
    f = @view.frame
    f.origin.x = 10
    f.origin.y = 10
    @view.frame = f

    @layout.context(@view) do
      retval = @layout.frame @layout.after(@another_view)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 130
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `after(view, right:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.after(@another_view, right: 8)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 138
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `after(view, width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.after(@another_view, width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 130
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `after(view, x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.after(@another_view, x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 140
    @view.frame.origin.y.should == 120
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

  it 'should support setting the frame via `right_of(view)`' do
    after = nil
    right_of = nil
    @layout.context(@view) do
      after = @layout.after(@another_view)
      right_of = @layout.right_of(@another_view)
    end
    right_of.origin.x.should == after.origin.x
    right_of.origin.y.should == after.origin.y
    right_of.size.width.should == after.size.width
    right_of.size.height.should == after.size.height
  end

  it 'should support setting the frame via `relative_to(view)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.relative_to(@another_view, {})
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `relative_to(view)` and ignore view origin' do
    f = @view.frame
    f.origin.x = 10
    f.origin.y = 10
    @view.frame = f

    @layout.context(@view) do
      retval = @layout.frame @layout.relative_to(@another_view, {})
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == @view_size.width
    @view.frame.size.height.should == @view_size.height
  end

  it 'should support setting the frame via `relative_to(view, width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.relative_to(@another_view, width: 10, height: 20)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 10
    @view.frame.origin.y.should == 100
    @view.frame.size.width.should == 10
    @view.frame.size.height.should == 20
  end

  it 'should support setting the frame via `relative_to(view, x:y:width:height:)`' do
    @layout.context(@view) do
      retval = @layout.frame @layout.relative_to(@another_view, x: 10, y: 20, width: 22, height: 12)
      retval.should == @view.frame
    end
    @view.frame.origin.x.should == 20
    @view.frame.origin.y.should == 120
    @view.frame.size.width.should == 22
    @view.frame.size.height.should == 12
  end

end
