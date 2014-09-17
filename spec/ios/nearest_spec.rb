describe 'MotionKit nearest element logic' do

  before do
    @subject = TestNearestLayout.new.build
  end

  it 'should support self_search' do
    found = nil
    @subject.self_search
    @subject.context(@subject.start_here) do
      found = @subject.nearest(:self_search)
    end
    found.should == @subject.expected_to_find
  end

  it 'should support child_search' do
    found = nil
    @subject.child_search
    @subject.context(@subject.start_here) do
      found = @subject.nearest(:child_search)
    end
    found.should == @subject.expected_to_find
  end

  it 'should support sibling_search' do
    found = nil
    @subject.sibling_search
    @subject.context(@subject.start_here) do
      found = @subject.nearest(:sibling_search)
    end
    found.should == @subject.expected_to_find
  end

  it 'should support siblings_child_search' do
    found = nil
    @subject.siblings_child_search
    @subject.context(@subject.start_here) do
      found = @subject.nearest(:siblings_child_search)
    end
    found.should == @subject.expected_to_find
  end

  it 'should support parent_search' do
    found = nil
    @subject.parent_search
    @subject.context(@subject.start_here) do
      found = @subject.nearest(:parent_search)
    end
    found.should == @subject.expected_to_find
  end

  it 'should support distant_search' do
    found = nil
    @subject.distant_search
    @subject.context(@subject.start_here) do
      found = @subject.nearest(:distant_search)
    end
    found.should == @subject.expected_to_find
  end

  it 'should support nearest(id, from: view)' do
    found = nil
    @subject.nearest_from_search
    @subject.context(@subject.start_here) do
      from_here = @subject.get(:from_here)
      found = @subject.nearest(:nearest_from_search, from: from_here)
    end
    found.should == @subject.expected_to_find
  end

  it 'should support nearest(id, from: id)' do
    found = nil
    @subject.nearest_from_search
    @subject.context(@subject.start_here) do
      found = @subject.nearest(:nearest_from_search, from: :from_here)
    end
    found.should == @subject.expected_to_find
  end

end
