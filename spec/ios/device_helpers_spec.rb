describe 'Device helpers' do

  before do
    @layout = MK::Layout.new
  end

  it 'should have device helpers' do
    @layout.context({}) do
      @layout.iphone?.should == true
      if UIScreen.mainScreen.bounds.size.width == 320
        @layout.iphone4?.should == true
      else
        @layout.iphone4?.should == false
      end
      if UIScreen.mainScreen.bounds.size.width == 375
        @layout.iphone47?.should == true
      else
        @layout.iphone47?.should == false
      end
      if UIScreen.mainScreen.bounds.size.width == 375
        @layout.iphone55?.should == true
      else
        @layout.iphone55?.should == false
      end
      @layout.iphone35?.should == false
      @layout.ipad?.should == false
      @layout.retina?.should == true
    end
  end

  it 'should have device (iphone do end) helpers' do
    @layout.context({}) do
      @check = false
      @layout.iphone do
        @check = true
      end
      @check.should == true

      @check = false
      @layout.iphone4 do
        @check = true
      end
      @check.should == true

      @check = false
      @layout.iphone35 do
        @check = true
      end
      @check.should == false

      @check = false
      @layout.ipad do
        @check = true
      end
      @check.should == false

      @check = false
      @layout.retina do
        @check = true
      end
      @check.should == true
    end
  end

end
