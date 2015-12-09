describe 'Orientation helpers' do

  before do
    @layout = MK::Layout.new
  end

  it 'should have orientation helpers' do
    @layout.context({}) do
      @layout.orientation?(UIInterfaceOrientationPortrait).should == true
      @layout.orientation?(UIInterfaceOrientationLandscapeLeft).should == false
      @layout.orientation?(UIInterfaceOrientationLandscapeRight).should == false
      @layout.orientation?(UIInterfaceOrientationPortraitUpsideDown).should == false
    end
  end

  it 'should have orientation (portrait?) helpers' do
    @layout.context({}) do
      @layout.portrait?.should == true
      @layout.upright?.should == true
      @layout.upside_down?.should == false
      @layout.landscape?.should == false
      @layout.landscape_left?.should == false
      @layout.landscape_right?.should == false
    end
  end

  it 'should have orientation (portrait do end) helpers' do
    @layout.context({}) do
      @check = false
      @layout.portrait do
        @check = true
      end
      @check.should == true

      @check = false
      @layout.upright do
        @check = true
      end
      @check.should == true

      @check = false
      @layout.upside_down do
        @check = true
      end
      @check.should == false

      @check = false
      @layout.landscape do
        @check = true
      end
      @check.should == false

      @check = false
      @layout.landscape_left do
        @check = true
      end
      @check.should == false

      @check = false
      @layout.landscape_right do
        @check = true
      end
      @check.should == false
    end
  end

end
