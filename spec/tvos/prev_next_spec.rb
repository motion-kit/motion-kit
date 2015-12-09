describe 'MotionKit prev/next element logic' do

  before do
    @subject = TestPrevNextLayout.new.build
  end

  it 'should find "nil" before "first"' do
    found = nil
    @subject.context(@subject.first_row) do
      found = @subject.prev(:row)
    end
    found.should == nil
  end

  it 'should find "first" before "second"' do
    found = nil
    @subject.context(@subject.second_row) do
      found = @subject.prev(:row)
    end
    found.should == @subject.first_row
  end

  it 'should find "second" before "third"' do
    found = nil
    @subject.context(@subject.third_row) do
      found = @subject.prev(:row)
    end
    found.should == @subject.second_row
  end

  it 'should find "second" after "first"' do
    found = nil
    @subject.context(@subject.first_row) do
      found = @subject.next(:row)
    end
    found.should == @subject.second_row
  end

  it 'should find "third" after "second"' do
    found = nil
    @subject.context(@subject.second_row) do
      found = @subject.next(:row)
    end
    found.should == @subject.third_row
  end

  it 'should find "nil" after "third"' do
    found = nil
    @subject.context(@subject.third_row) do
      found = @subject.next(:row)
    end
    found.should == nil
  end

  describe 'Using :from option' do

    before do
      @subject.from_search
      @start_here = @subject.get(:start_here)
    end

    it 'should find "nil" before "first"' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.prev(:row, from: @subject.first_row)
      end
      found.should == nil
    end

    it 'should find "first" before "second"' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.prev(:row, from: @subject.second_row)
      end
      found.should == @subject.first_row
    end

    it 'should find "second" before "third"' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.prev(:row, from: @subject.third_row)
      end
      found.should == @subject.second_row
    end

    it 'should find "second" after "first"' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.next(:row, from: @subject.first_row)
      end
      found.should == @subject.second_row
    end

    it 'should find "third" after "second"' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.next(:row, from: @subject.second_row)
      end
      found.should == @subject.third_row
    end

    it 'should find "nil" after "third"' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.next(:row, from: @subject.third_row)
      end
      found.should == nil
    end

  end

  describe 'Using :from option and symbols' do

    before do
      @subject.from_symbol_search
      @start_here = @subject.get(:start_here)
    end

    it 'should find prev(:first_row, from: :second_row)' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.prev(:first_row, from: :second_row)
      end
      found.should == @subject.first_row
    end

    it 'should find next(:third_row, from: :second_row)' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.next(:third_row, from: :second_row)
      end
      found.should == @subject.third_row
    end

    it 'should find prev(:first_row, from: :third_row)' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.prev(:first_row, from: :third_row)
      end
      found.should == @subject.first_row
    end

    it 'should find next(:third_row, from: :first_row)' do
      found = nil
      @subject.context(@start_here) do
        found = @subject.next(:third_row, from: :first_row)
      end
      found.should == @subject.third_row
    end

  end

end
