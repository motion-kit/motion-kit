class Viewish
  def superview
    @superview ||= Viewish.new
  end

  def frame
    CGRect.new([10, 10], [100, 44])
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

end
