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
      found = @subject.previous(:row)
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

end
