# TODO disabled until CGColor is fixed
return true

describe 'CALayerHelpers' do

  before do
    @subject = TestCALayerLayout.new.build
  end

  describe 'should style a CALayer' do
    describe 'should style :gradient layer' do
      it 'should set the frame' do
        @subject.get(:gradient).frame.should == CGRectMake(0, 0, 20, 20)
      end
      it 'should set the colors' do
        @subject.get(:gradient).colors.length.should == 2
      end
    end
    describe 'should style :bottom layer' do
      it 'should set the frame' do
        @subject.get(:bottom).frame.should == CGRectMake(0, 20, 20, 10)
      end
    end
  end

end
