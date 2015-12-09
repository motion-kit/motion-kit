class Viewish
  def superview
    @superview ||= Viewish.new
  end

  def frame
    @frame
  end

  def initialize(size=nil)
    size ||= [100, 44]
    @frame = CGRect.new([10, 10], size)
  end

  def intrinsicContentSize
    CGSize.new(80, 20)
  end
end


describe 'MotionKit.calculate' do

  it 'should return static numbers' do
    MotionKit.calculate(nil, nil, 1).should == 1
  end

  it 'should call blocks' do
    a = 'hi!'
    MotionKit.calculate(a, nil, ->{
      self.should == a
      2
    }).should == 2
  end

  it 'should return percents with :width' do
    MotionKit.calculate(Viewish.new, :width, '50%').should == 50
  end

  it 'should return percents with :height' do
    MotionKit.calculate(Viewish.new, :height, '50%').should == 22
  end

  it 'should return :auto with :width' do
    MotionKit.calculate(Viewish.new, :width, :auto).should == 80
  end

  it 'should return :auto with :height' do
    MotionKit.calculate(Viewish.new, :height, :auto).should == 20
  end

  describe 'should return percents with offset' do
    it ':width, 50% + 10' do
      MotionKit.calculate(Viewish.new, :width, '50% + 10').should == 60
    end
    it ':width, 50% - 10' do
      MotionKit.calculate(Viewish.new, :width, '50% - 10').should == 40
    end
    it ':width, 25% + 5' do
      MotionKit.calculate(Viewish.new, :width, '25% + 5').should == 30
    end
    it ':height, 50% + 10' do
      MotionKit.calculate(Viewish.new, :height, '50% + 10').should == 32
    end
    it ':height, 50% - 10' do
      MotionKit.calculate(Viewish.new, :height, '50% - 10').should == 12
    end
    it ':height, 25% + 5' do
      MotionKit.calculate(Viewish.new, :height, '25% + 5').should == 16
    end
  end

  describe 'should return point with :origin' do
    it 'should support two numbers' do
      pt = MotionKit.calculate(Viewish.new, :origin, [10, 20])
      pt.x.should == 10
      pt.y.should == 20
    end

    it 'should support a point' do
      pt = MotionKit.calculate(Viewish.new, :origin, CGPoint.new(10, 20))
      pt.x.should == 10
      pt.y.should == 20
    end

    it 'should support {:x, :y}' do
      pt = MotionKit.calculate(Viewish.new, :origin, {x: 10, y: 20})
      pt.x.should == 10
      pt.y.should == 20
    end

    it 'should support {:left, :top}' do
      pt = MotionKit.calculate(Viewish.new, :origin, {left: 10, top: 20})
      pt.x.should == 10
      pt.y.should == 20
    end

    it 'should support x as percent' do
      pt = MotionKit.calculate(Viewish.new, :origin, ['10%', 20])
      pt.x.should == 10
      pt.y.should == 20
    end

    it 'should support y as percent' do
      pt = MotionKit.calculate(Viewish.new, :origin, [10, '50%'])
      pt.x.should == 10
      pt.y.should == 22
    end

    it 'should support two percents' do
      pt = MotionKit.calculate(Viewish.new, :origin, ['50%', '50%'])
      pt.x.should == 50
      pt.y.should == 22
    end

    it 'should support {:right, :bottom}' do
      pt = MotionKit.calculate(Viewish.new([10, 10]), :origin, {right: '100%', bottom: '100%'})
      pt.x.should == 90
      pt.y.should == 34
    end

    it 'should support {:right, :bottom} with offsets' do
      pt = MotionKit.calculate(Viewish.new([10, 10]), :origin, {right: '100%-8', bottom: '100%-8'})
      pt.x.should == 82
      pt.y.should == 26
    end

    it 'should support two percents with offsets' do
      pt = MotionKit.calculate(Viewish.new, :origin, ['50%-10', '50%-10'])
      pt.x.should == 40
      pt.y.should == 12
    end
  end

  describe 'should return size with :size' do

    it 'should support two numbers' do
      size = MotionKit.calculate(Viewish.new, :size, [10, 20])
      size.width.should == 10
      size.height.should == 20
    end

    it 'should support a point' do
      size = MotionKit.calculate(Viewish.new, :size, CGSize.new(10, 20))
      size.width.should == 10
      size.height.should == 20
    end

    it 'should support {:w, :h}' do
      size = MotionKit.calculate(Viewish.new, :size, {w: 10, h: 20})
      size.width.should == 10
      size.height.should == 20
    end

    it 'should support {:width, :height}' do
      size = MotionKit.calculate(Viewish.new, :size, {width: 10, height: 20})
      size.width.should == 10
      size.height.should == 20
    end

    it 'should support width as percent' do
      size = MotionKit.calculate(Viewish.new, :size, ['10%', 20])
      size.width.should == 10
      size.height.should == 20
    end

    it 'should support height as percent' do
      size = MotionKit.calculate(Viewish.new, :size, [10, '50%'])
      size.width.should == 10
      size.height.should == 22
    end

    it 'should support two percents' do
      size = MotionKit.calculate(Viewish.new, :size, ['50%', '50%'])
      size.width.should == 50
      size.height.should == 22
    end

    it 'should support two percents with offsets' do
      size = MotionKit.calculate(Viewish.new, :size, ['50%-10', '50%-10'])
      size.width.should == 40
      size.height.should == 12
    end

    it 'should support :auto' do
      size = MotionKit.calculate(Viewish.new, :size, :auto)
      size.width.should == 80
      size.height.should == 20
    end

    it 'should support :full' do
      size = MotionKit.calculate(Viewish.new, :size, :full)
      size.width.should == 100
      size.height.should == 44
    end

    it 'should support :scale width' do
      size = MotionKit.calculate(Viewish.new, :size, [:scale, 40])
      size.width.should == 160
      size.height.should == 40
    end

    it 'should support :scale width, :auto height' do
      size = MotionKit.calculate(Viewish.new, :size, [:scale, :auto])
      size.width.should == 80
      size.height.should == 20
    end

    it 'should support :scale height' do
      size = MotionKit.calculate(Viewish.new, :size, [40, :scale])
      size.width.should == 40
      size.height.should == 10
    end

    it 'should support :scale height, :auto width' do
      size = MotionKit.calculate(Viewish.new, :size, [:auto, :scale])
      size.width.should == 80
      size.height.should == 20
    end

  end

  describe 'should return frame with :frame' do

    it 'should support four numbers [[a, b], [c, d]]' do
      frame = MotionKit.calculate(Viewish.new, :frame, [[10, 20], [30, 40]])
      frame.origin.x.should == 10
      frame.origin.y.should == 20
      frame.size.width.should == 30
      frame.size.height.should == 40
    end

    it 'should support four numbers [a, b, c, d]' do
      frame = MotionKit.calculate(Viewish.new, :frame, [10, 20, 30, 40])
      frame.origin.x.should == 10
      frame.origin.y.should == 20
      frame.size.width.should == 30
      frame.size.height.should == 40
    end

    it 'should support a point and a size' do
      frame = MotionKit.calculate(Viewish.new, :frame, [CGPoint.new(10, 20), CGSize.new(30, 40)])
      frame.origin.x.should == 10
      frame.origin.y.should == 20
      frame.size.width.should == 30
      frame.size.height.should == 40
    end

    it 'should support {:x, :y, :w, :h}' do
      frame = MotionKit.calculate(Viewish.new, :frame, {x: 10, y: 20, w: 30, h: 40})
      frame.origin.x.should == 10
      frame.origin.y.should == 20
      frame.size.width.should == 30
      frame.size.height.should == 40
    end

    it 'should support {:left, :top, :width, :height}' do
      frame = MotionKit.calculate(Viewish.new, :frame, {left: 10, top: 20, width: 30, height: 40})
      frame.origin.x.should == 10
      frame.origin.y.should == 20
      frame.size.width.should == 30
      frame.size.height.should == 40
    end

    it 'should support four percents' do
      frame = MotionKit.calculate(Viewish.new, :frame, [['25%', '25%'], ['50%', '50%']])
      frame.origin.x.should == 25
      frame.origin.y.should == 11
      frame.size.width.should == 50
      frame.size.height.should == 22
    end

    it 'should support four percents with offsets' do
      frame = MotionKit.calculate(Viewish.new, :frame, [['25%-10', '25%-10'], ['50%+20', '50%+20']])
      frame.origin.x.should == 15
      frame.origin.y.should == 1
      frame.size.width.should == 70
      frame.size.height.should == 42
    end

    it 'should support :auto' do
      frame = MotionKit.calculate(Viewish.new, :frame, :auto)
      frame.origin.x.should == 0
      frame.origin.y.should == 0
      frame.size.width.should == 80
      frame.size.height.should == 20
    end

    it 'should support :full' do
      frame = MotionKit.calculate(Viewish.new, :frame, :full)
      frame.origin.x.should == 0
      frame.origin.y.should == 0
      frame.size.width.should == 100
      frame.size.height.should == 44
    end

    it 'should support :center' do
      frame = MotionKit.calculate(Viewish.new([50, 22]), :frame, :center)
      frame.origin.x.should == 25
      frame.origin.y.should == 11
      frame.size.width.should == 50
      frame.size.height.should == 22
    end

    it 'should support [:center, :auto]' do
      frame = MotionKit.calculate(Viewish.new, :frame, [:center, :auto])
      frame.origin.x.should == 10
      frame.origin.y.should == 12
      frame.size.width.should == 80
      frame.size.height.should == 20
    end

    it 'should support :scale' do
      frame = MotionKit.calculate(Viewish.new, :frame, [:center, [:scale, 40]])
      frame.origin.x.should == -30
      frame.origin.y.should == 2
      frame.size.width.should == 160
      frame.size.height.should == 40
    end

  end

end
