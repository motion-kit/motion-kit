describe TestDeferredLayout do

  before do
    @layout = TestDeferredLayout.new
    @layout.view
  end

  describe 'from layout' do
    it 'should run the deferred block' do
      @layout.layout_test_ran.should == true
    end

    it 'should have assigned the value 0' do
      @layout.layout_test_is_0.should == true
    end

    it 'should end up with the value 1' do
      @layout.layout_test.should == 1
    end
  end

  describe 'from create_view' do
    before do
      @layout.create_view
    end

    it 'should run the deferred block' do
      @layout.create_view_test_ran.should == true
    end

    it 'should have assigned the value 0' do
      @layout.create_view_test_is_0.should == true
    end

    it 'should end up with the value 1' do
      @layout.create_view_test.should == 1
    end
  end

  describe 'from error_no_context' do
    it 'should raise InvalidDeferredError' do
      -> do
        @layout.error_no_context
      end.should.raise(MK::InvalidDeferredError)
    end
  end

  describe 'from nested_blocks' do
    before do
      @layout.nested_blocks
    end

    it 'should run the deferred block' do
      @layout.nested_blocks_test_ran.should == true
    end
    it 'should have assigned the value 0' do
      @layout.nested_blocks_test_is_0.should == true
    end
    it 'should have assigned the value 1' do
      @layout.nested_blocks_test_is_1.should == true
    end
    it 'should end up with the value 1' do
      @layout.nested_blocks_test.should == 2
    end
  end

end
