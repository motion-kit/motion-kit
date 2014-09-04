describe TestLayerHelpers do
  before do
    @subject = TestLayerHelpers.new
  end

  it 'should create a CALayer root' do
    @subject.view.should.be.kind_of(CALayer)
  end

  it 'should add sublayers' do
    @subject.view.sublayers.length.should == 3
  end

  describe 'should have styled sublayers' do
    before do
      @subject = TestLayerHelpers.new
    end

    it 'should have a CALayer' do
      @subject.view.sublayers[0].opacity.should == 0.5
      @subject.view.sublayers[0].backgroundColor.should.not == nil
    end

    it 'should have a CAGradientLayer' do
      @subject.view.sublayers[1].opacity.should == 0.5
      @subject.view.sublayers[1].colors.should.not == nil
      @subject.view.sublayers[1].colors.length.should == 2
    end

    it 'should have a CAShapeLayer' do
      @subject.view.sublayers[2].opacity.should == 0.5
      @subject.view.sublayers[2].path.should.not == nil
    end
  end

end
