describe 'Frame helpers' do

  before do
    @layout = TestEmptyLayout.new
    @window = NSWindow.alloc.init
    @window.setFrame([[0, 0], [500, 500]], display: true)
    @window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @layout.root = @window

    @another_window = NSWindow.alloc.init
    @another_window.setFrame([[200, 200], [200, 200]], display: true)
    @another_window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']

    @screen_size = NSScreen.mainScreen.frame.size
  end

  it 'should support `x` method' do
    @layout.context(@window) do
      retval = @layout.x 1
      retval.should == CGRectGetMinX(@window.frame)
      @window.frame.origin.x.should == 1

      retval = @layout.x '100% - 1'
      retval.should == CGRectGetMinX(@window.frame)
      @window.frame.origin.x.should == @screen_size.width - 1
    end
  end

  it 'should support `left` method' do
    @layout.context(@window) do
      retval = @layout.left 1
      retval.should == CGRectGetMinX(@window.frame)
      @window.frame.origin.x.should == 1

      retval = @layout.left '100% - 1'
      retval.should == CGRectGetMinX(@window.frame)
      @window.frame.origin.x.should == @screen_size.width - 1
    end
  end

  it 'should support `right` method' do
    @layout.context(@window) do
      retval = @layout.right 1
      retval.should == CGRectGetMaxX(@window.frame)
      @window.frame.origin.x.should == 1 - @window.frame.size.width

      retval = @layout.right '100% - 1'
      retval.should == CGRectGetMaxX(@window.frame)
      @window.frame.origin.x.should == @screen_size.width - 1 - @window.frame.size.width
    end
  end

  it 'should support `center_x` method' do
    @layout.context(@window) do
      retval = @layout.center_x @window.frame.size.width / 2
      retval.should == CGRectGetMidX(@window.frame)
      @window.frame.origin.x.should == 0

      retval = @layout.center_x '50%'
      retval.should == CGRectGetMidX(@window.frame)
      retval.should == @screen_size.width / 2
    end
  end

  it 'should support `middle_x` method' do
    @layout.context(@window) do
      retval = @layout.middle_x @window.frame.size.width / 2
      retval.should == CGRectGetMidX(@window.frame)
      @window.frame.origin.x.should == 0

      retval = @layout.middle_x '50%'
      retval.should == CGRectGetMidX(@window.frame)
      retval.should == @screen_size.width / 2
    end
  end

  it 'should support `y` method' do
    @layout.context(@window) do
      retval = @layout.y 1
      retval.should == CGRectGetMinY(@window.frame)
      @window.frame.origin.y.should == 1

      retval = @layout.y '100% - 1'
      retval.should == CGRectGetMinY(@window.frame)
      @window.frame.origin.y.should == @screen_size.height - 1
    end
  end

  it 'should support `bottom` method' do
    @layout.context(@window) do
      retval = @layout.bottom 1
      retval.should == CGRectGetMinY(@window.frame)
      @window.frame.origin.y.should == 1

      retval = @layout.bottom '100% - 1'
      retval.should == CGRectGetMinY(@window.frame)
      @window.frame.origin.y.should == @screen_size.height - 1
    end
  end

  it 'should support `top` method' do
    @layout.context(@window) do
      retval = @layout.top 1
      retval.should == CGRectGetMaxY(@window.frame)
      @window.frame.origin.y.should == 1 - @window.frame.size.height

      retval = @layout.top '100% - 1'
      retval.should == CGRectGetMaxY(@window.frame)
      @window.frame.origin.y.should == @screen_size.height - 1 - @window.frame.size.height
    end
  end

  it 'should support `center_y` method' do
    @layout.context(@window) do
      retval = @layout.center_y @window.frame.size.height / 2
      retval.should == CGRectGetMidY(@window.frame)
      @window.frame.origin.y.should == 0

      retval = @layout.center_y '50%'
      retval.should == CGRectGetMidY(@window.frame)
      retval.should == @screen_size.height / 2
    end
  end

  it 'should support `middle_y` method' do
    @layout.context(@window) do
      retval = @layout.middle_y @window.frame.size.height / 2
      retval.should == CGRectGetMidY(@window.frame)
      @window.frame.origin.y.should == 0

      retval = @layout.middle_y '50%'
      retval.should == CGRectGetMidY(@window.frame)
      retval.should == @screen_size.height / 2
    end
  end

  it 'should support `width` method' do
    @layout.context(@window) do
      retval = @layout.width 1
      retval.should == CGRectGetWidth(@window.frame)
      @window.frame.size.width.should == 1

      retval = @layout.width '100% - 1'
      retval.should == CGRectGetWidth(@window.frame)
      @window.frame.size.width.should == @screen_size.width - 1
    end
  end

  it 'should support `w` method' do
    @layout.context(@window) do
      retval = @layout.w 1
      retval.should == CGRectGetWidth(@window.frame)
      @window.frame.size.width.should == 1

      retval = @layout.w '100% - 1'
      retval.should == CGRectGetWidth(@window.frame)
      @window.frame.size.width.should == @screen_size.width - 1
    end
  end

  it 'should support `height` method' do
    @layout.context(@window) do
      retval = @layout.height 1
      retval.should == CGRectGetHeight(@window.frame)
      @window.frame.size.height.should == 1

      retval = @layout.height '100% - 1'
      retval.should == CGRectGetHeight(@window.frame)
      @window.frame.size.height.should == @screen_size.height - 1
    end
  end

  it 'should support `h` method' do
    @layout.context(@window) do
      retval = @layout.h 1
      retval.should == CGRectGetHeight(@window.frame)
      @window.frame.size.height.should == 1

      retval = @layout.h '100% - 1'
      retval.should == CGRectGetHeight(@window.frame)
      @window.frame.size.height.should == @screen_size.height - 1
    end
  end

  it 'should support `origin([])` method' do
    @layout.context(@window) do
      retval = @layout.origin [1, 2]
      retval.should == @window.frame.origin
      @window.frame.origin.x.should == 1
      @window.frame.origin.y.should == 2

      retval = @layout.origin ['100% - 1', '100% - 2']
      retval.should == @window.frame.origin
      @window.frame.origin.x.should == @screen_size.width - 1
      @window.frame.origin.y.should == @screen_size.height - 2
    end
  end

  it 'should support `origin({})` method' do
    @layout.context(@window) do
      retval = @layout.origin x: 1, y: 2
      retval.should == @window.frame.origin
      @window.frame.origin.x.should == 1
      @window.frame.origin.y.should == 2

      retval = @layout.origin x: '100% - 1', y: '100% - 2'
      retval.should == @window.frame.origin
      @window.frame.origin.x.should == @screen_size.width - 1
      @window.frame.origin.y.should == @screen_size.height - 2
    end
  end

  it 'should support `origin({relative: true})` method' do
    @layout.context(@window) do
      retval = @layout.origin x: 0, y: 0, right: 1, up: 2, relative: true
      retval.should == @window.frame.origin
      @window.frame.origin.x.should == 1
      @window.frame.origin.y.should == 2

      retval = @layout.origin x: '100%', y: '100%', left: 1, down: 2, relative: true
      retval.should == @window.frame.origin
      @window.frame.origin.x.should == @screen_size.width - 1
      @window.frame.origin.y.should == @screen_size.height - 2
    end
  end

  it 'should support `center([])` method' do
    @layout.context(@window) do
      retval = @layout.center [@window.frame.size.width / 2, @window.frame.size.height / 2]
      retval.x.should == CGRectGetMidX(@window.frame)
      retval.y.should == CGRectGetMidY(@window.frame)
      @window.frame.origin.x.should == 0
      @window.frame.origin.y.should == 0

      retval = @layout.center ['50%', '50%']
      retval.x.should == CGRectGetMidX(@window.frame)
      retval.y.should == CGRectGetMidY(@window.frame)
      retval.x.should == @screen_size.width / 2
      retval.y.should == @screen_size.height / 2
    end
  end

  it 'should support `center({})` method' do
    @layout.context(@window) do
      retval = @layout.center x: @window.frame.size.width / 2, y: @window.frame.size.height / 2
      retval.x.should == CGRectGetMidX(@window.frame)
      retval.y.should == CGRectGetMidY(@window.frame)
      @window.frame.origin.x.should == 0
      @window.frame.origin.y.should == 0

      retval = @layout.center x: '50%', y: '50%'
      retval.x.should == CGRectGetMidX(@window.frame)
      retval.y.should == CGRectGetMidY(@window.frame)
      retval.x.should == @screen_size.width / 2
      retval.y.should == @screen_size.height / 2
    end
  end

  it 'should support `center({relative: true})` method' do
    @layout.context(@window) do
      retval = @layout.center x: @window.frame.size.width / 2, y: @window.frame.size.height / 2, right: 1, up: 2, relative: true
      retval.x.should == CGRectGetMidX(@window.frame)
      retval.y.should == CGRectGetMidY(@window.frame)
      @window.frame.origin.x.should == 1
      @window.frame.origin.y.should == 2

      retval = @layout.center x: '50%', y: '50%', left: 1, down: 2, relative: true
      retval.x.should == CGRectGetMidX(@window.frame)
      retval.y.should == CGRectGetMidY(@window.frame)
      retval.x.should == @screen_size.width / 2 - 1
      retval.y.should == @screen_size.height / 2 - 2
    end
  end

  it 'should support `size` method' do
    @layout.context(@window) do
      retval = @layout.size [1, 2]
      retval.should == @window.frame.size
      @window.frame.size.width.should == 1
      @window.frame.size.height.should == 2

      retval = @layout.size ['100% - 1', '100% - 2']
      retval.should == @window.frame.size
      @window.frame.size.width.should == @screen_size.width - 1
      @window.frame.size.height.should == @screen_size.height - 2
    end
  end

  it 'should support `frame` arrays [[x, y], [w, h]]' do
    @layout.context(@window) do
      retval = @layout.frame [[1, 2], [3, 4]]
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 1
    @window.frame.origin.y.should == 2
    @window.frame.size.width.should == 3
    @window.frame.size.height.should == 4
  end

  it 'should support `frame` arrays [x, y, w, h]' do
    @layout.context(@window) do
      retval = @layout.frame [1, 2, 3, 4]
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 1
    @window.frame.origin.y.should == 2
    @window.frame.size.width.should == 3
    @window.frame.size.height.should == 4
  end

  it 'should support `frame :full`' do
    @layout.context(@window) do
      retval = @layout.frame :full
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 0
    @window.frame.origin.y.should == 0
    @window.frame.size.width.should == @screen_size.width
    @window.frame.size.height.should == @screen_size.height
  end

  it 'should support `frame :center`' do
    @layout.context(@window) do
      retval = @layout.frame :center
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - @window.frame.size.width) / 2
    @window.frame.origin.y.should == (@screen_size.height - @window.frame.size.height) / 2
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_bottom_left`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_left()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 0
    @window.frame.origin.y.should == 0
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_bottom_left(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_left(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 0
    @window.frame.origin.y.should == 0
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_bottom_left(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_left(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 10
    @window.frame.origin.y.should == 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom_left(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_left(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 10
    @window.frame.origin.y.should == 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom_left(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_left(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == -10
    @window.frame.origin.y.should == -20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  # ============================================================================

  it 'should support setting the frame via `from_bottom_left(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_left(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_bottom`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - @window.frame.size.width) / 2
    @window.frame.origin.y.should == 0
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_bottom(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 10) / 2
    @window.frame.origin.y.should == 0
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_bottom(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 + 10
    @window.frame.origin.y.should == 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 + 10
    @window.frame.origin.y.should == 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 - 10
    @window.frame.origin.y.should == -20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + (@another_window.frame.size.width - @window.frame.size.width) / 2 + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_bottom_right`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_right()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - @window.frame.size.width
    @window.frame.origin.y.should == 0
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_bottom_right(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_right(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 10
    @window.frame.origin.y.should == 0
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_bottom_right(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_right(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 + 10
    @window.frame.origin.y.should == 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom_right(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_right(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 + 10
    @window.frame.origin.y.should == 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom_right(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_right(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 - 10
    @window.frame.origin.y.should == -20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_bottom_right(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_bottom_right(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width - @window.frame.size.width + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_left`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_left()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 0
    @window.frame.origin.y.should == (@screen_size.height - @window.frame.size.height) / 2
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_left(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_left(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 0
    @window.frame.origin.y.should == (@screen_size.height - 20) / 2
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_left(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_left(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_left(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_left(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_left(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_left(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == -10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_left(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_left(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + (@another_window.frame.size.height - @window.frame.size.height) / 2 + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_center`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_center()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - @window.frame.size.width) / 2
    @window.frame.origin.y.should == (@screen_size.height - @window.frame.size.height) / 2
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_center(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_center(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 10) / 2
    @window.frame.origin.y.should == (@screen_size.height - 20) / 2
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_center(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_center(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 + 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_center(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_center(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 + 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_center(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_center(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 - 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_center(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_center(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + (@another_window.frame.size.width - @window.frame.size.width) / 2 + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + (@another_window.frame.size.height - @window.frame.size.height) / 2 + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_right`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_right()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - @window.frame.size.width
    @window.frame.origin.y.should == (@screen_size.height - @window.frame.size.height) / 2
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_right(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_right(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 10
    @window.frame.origin.y.should == (@screen_size.height - 20) / 2
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_right(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_right(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 + 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_right(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_right(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 + 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_right(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_right(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 - 10
    @window.frame.origin.y.should == (@screen_size.height - 12) / 2 - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_right(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_right(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width - @window.frame.size.width + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + (@another_window.frame.size.height - @window.frame.size.height) / 2 + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_top_left`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_left()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 0
    @window.frame.origin.y.should == @screen_size.height - @window.frame.size.height
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_top_left(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_left(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 0
    @window.frame.origin.y.should == @screen_size.height - 20
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_top_left(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_left(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 10
    @window.frame.origin.y.should == @screen_size.height - 12 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_left(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_left(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == 10
    @window.frame.origin.y.should == @screen_size.height - 12 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_left(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_left(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == -10
    @window.frame.origin.y.should == @screen_size.height - 12 - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_left(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_left(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height - @window.frame.size.height + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_top`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - @window.frame.size.width) / 2
    @window.frame.origin.y.should == @screen_size.height - @window.frame.size.height
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_top(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 10) / 2
    @window.frame.origin.y.should == @screen_size.height - 20
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_top(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 + 10
    @window.frame.origin.y.should == @screen_size.height - 12 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 + 10
    @window.frame.origin.y.should == @screen_size.height - 12 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == (@screen_size.width - 22) / 2 - 10
    @window.frame.origin.y.should == @screen_size.height - 12 - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + (@another_window.frame.size.width - @window.frame.size.width) / 2 + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height - @window.frame.size.height + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_top_right`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_right()
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - @window.frame.size.width
    @window.frame.origin.y.should == @screen_size.height - @window.frame.size.height
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `from_top_right(width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_right(width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 10
    @window.frame.origin.y.should == @screen_size.height - 20
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `from_top_right(x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_right(x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 + 10
    @window.frame.origin.y.should == @screen_size.height - 12 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_right(right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_right(right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 + 10
    @window.frame.origin.y.should == @screen_size.height - 12 + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_right(left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_right(left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @screen_size.width - 22 - 10
    @window.frame.origin.y.should == @screen_size.height - 12 - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `from_top_right(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.from_top_right(@another_window, x: 1, y: 1)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width - @window.frame.size.width + 1
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height - @window.frame.size.height + 1
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `above(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.above(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `above(window)` and ignore view origin' do
    f = @window.frame
    f.origin.x = 10
    f.origin.y = 10
    @window.setFrame(f, display: false)

    @layout.context(@window) do
      retval = @layout.frame @layout.above(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `above(window, down:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.above(@another_window, down: 8)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height - 8
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `above(window, width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.above(@another_window, width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `above(window, x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.above(@another_window, x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 10
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `above(window, right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.above(@another_window, right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 10
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `above(window, left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.above(@another_window, left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x - 10
    @window.frame.origin.y.should == @another_window.frame.origin.y + @another_window.frame.size.height - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `below(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.below(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y - @window.frame.size.height
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `below(window)` and ignore view origin' do
    f = @window.frame
    f.origin.x = 10
    f.origin.y = 10
    @window.setFrame(f, display: false)

    @layout.context(@window) do
      retval = @layout.frame @layout.below(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y - @window.frame.size.height
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `below(view, up:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.below(@another_window, up: 8)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y - @window.frame.size.height + 8
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `below(view, width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.below(@another_window, width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y - @window.frame.size.height
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `below(view, x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.below(@another_window, x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 10
    @window.frame.origin.y.should == @another_window.frame.origin.y - @window.frame.size.height + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `below(view, right:up:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.below(@another_window, right: 10, up: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 10
    @window.frame.origin.y.should == @another_window.frame.origin.y - @window.frame.size.height + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `below(view, left:down:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.below(@another_window, left: 10, down: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x - 10
    @window.frame.origin.y.should == @another_window.frame.origin.y - @window.frame.size.height - 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `before(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.before(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x - @window.frame.size.width
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `before(window)` and ignore view origin' do
    f = @window.frame
    f.origin.x = 10
    f.origin.y = 10
    @window.setFrame(f, display: false)

    @layout.context(@window) do
      retval = @layout.frame @layout.before(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x - @window.frame.size.width
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `before(view, left:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.before(@another_window, left: 8)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x - @window.frame.size.width - 8
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `before(view, width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.before(@another_window, width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x - @window.frame.size.width
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `before(view, x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.before(@another_window, x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x - @window.frame.size.width + 10
    @window.frame.origin.y.should == @another_window.frame.origin.y + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `left_of(window)`' do
    before = nil
    left_of = nil
    @layout.context(@window) do
      before = @layout.before(@another_window)
      left_of = @layout.left_of(@another_window)
    end
    left_of.origin.x.should == before.origin.x
    left_of.origin.y.should == before.origin.y
    left_of.size.width.should == before.size.width
    left_of.size.height.should == before.size.height
  end

  it 'should support setting the frame via `after(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.after(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `after(window)` and ignore view origin' do
    f = @window.frame
    f.origin.x = 10
    f.origin.y = 10
    @window.setFrame(f, display: false)

    @layout.context(@window) do
      retval = @layout.frame @layout.after(@another_window)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `after(view, right:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.after(@another_window, right: 8)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width + 8
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `after(view, width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.after(@another_window, width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `after(view, x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.after(@another_window, x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + @another_window.frame.size.width + 10
    @window.frame.origin.y.should == @another_window.frame.origin.y + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

  it 'should support setting the frame via `right_of(window)`' do
    after = nil
    right_of = nil
    @layout.context(@window) do
      after = @layout.after(@another_window)
      right_of = @layout.right_of(@another_window)
    end
    right_of.origin.x.should == after.origin.x
    right_of.origin.y.should == after.origin.y
    right_of.size.width.should == after.size.width
    right_of.size.height.should == after.size.height
  end

  it 'should support setting the frame via `relative_to(window)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.relative_to(@another_window, {})
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `relative_to(window)` and ignore view origin' do
    f = @window.frame
    f.origin.x = 10
    f.origin.y = 10
    @window.setFrame(f, display: false)

    @layout.context(@window) do
      retval = @layout.frame @layout.relative_to(@another_window, {})
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == @window.frame.size.width
    @window.frame.size.height.should == @window.frame.size.height
  end

  it 'should support setting the frame via `relative_to(view, width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.relative_to(@another_window, width: 10, height: 20)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x
    @window.frame.origin.y.should == @another_window.frame.origin.y
    @window.frame.size.width.should == 10
    @window.frame.size.height.should == 20
  end

  it 'should support setting the frame via `relative_to(view, x:y:width:height:)`' do
    @layout.context(@window) do
      retval = @layout.frame @layout.relative_to(@another_window, x: 10, y: 20, width: 22, height: 12)
      retval.should == @window.frame
    end
    @window.frame.origin.x.should == @another_window.frame.origin.x + 10
    @window.frame.origin.y.should == @another_window.frame.origin.y + 20
    @window.frame.size.width.should == 22
    @window.frame.size.height.should == 12
  end

end
