describe 'MotionKit utility methods' do

  it 'should objc-ify a string' do
    MotionKit.objective_c_method_name('this_is_my_string').should == 'thisIsMyString'
  end

  it 'should camel case a string' do
    MotionKit.camel_case('this_is_my_string').should == 'ThisIsMyString'
  end

  it 'should return the UIView appearance class' do
    MotionKit.appearance_class.should.be.kind_of(Class)
  end

  describe 'traversal methods' do
    before do
      view = UIView.new
      view.tag = 1
      subview1 = UIButton.new
      subview1.tag = 2
      subview2 = UILabel.new
      subview2.tag = 3
      subview3 = UILabel.new
      subview3.tag = 4
      subview4 = UIView.new
      subview4.tag = 5
      subview5 = UIButton.new
      subview5.tag = 6
      subview6 = UILabel.new
      subview6.tag = 7

      view.addSubview(subview1)
      view.addSubview(subview2)
      view.addSubview(subview3)
      view.addSubview(subview4)

      subview4.addSubview(subview5)
      subview4.addSubview(subview6)

      @subject = view
    end

    it 'should return the first UIButton that matches' do
      found = MotionKit.find_first_view(@subject) { |view| view.is_a?(UIButton) }
      found.should.be.kind_of(UIButton)
      found.tag.should == 2
    end

    it 'should return the first UILabel that matches' do
      found = MotionKit.find_first_view(@subject) { |view| view.is_a?(UILabel) }
      found.should.be.kind_of(UILabel)
      found.tag.should == 3
    end

    it 'should return nil for first UIImage' do
      found = MotionKit.find_first_view(@subject) { |view| view.is_a?(UIImage) }
      found.should == nil
    end

    it 'should return the last UIButton that matches' do
      found = MotionKit.find_last_view(@subject) { |view| view.is_a?(UIButton) }
      found.should.be.kind_of(UIButton)
      found.tag.should == 6
    end

    it 'should return the last UILabel that matches' do
      found = MotionKit.find_last_view(@subject) { |view| view.is_a?(UILabel) }
      found.should.be.kind_of(UILabel)
      found.tag.should == 7
    end

    it 'should return nil for last UIImage' do
      found = MotionKit.find_last_view(@subject) { |view| view.is_a?(UIImage) }
      found.should == nil
    end

    it 'should return all the UIButton that match' do
      found = MotionKit.find_all_views(@subject) { |view| view.is_a?(UIButton) }
      found.length.should == 2
      found.map { |view| view.tag }.should == [2, 6]
    end

    it 'should return all the UILabel that match' do
      found = MotionKit.find_all_views(@subject) { |view| view.is_a?(UILabel) }
      found.length.should == 3
      found.map { |view| view.tag }.should == [3, 4, 7]
    end

    it 'should return all the UIView that match' do
      found = MotionKit.find_all_views(@subject) { |view| view.is_a?(UIView) }
      found.length.should == 7
      found.map { |view| view.tag }.should == [1, 2, 3, 4, 5, 6, 7]
    end

    it 'should return [] for all UIImages' do
      found = MotionKit.find_all_views(@subject) { |view| view.is_a?(UIImage) }
      found.should == []
    end

  end

end
