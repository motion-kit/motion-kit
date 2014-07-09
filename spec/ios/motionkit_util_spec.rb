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

end
