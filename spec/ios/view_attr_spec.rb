describe 'View attr' do

  before do
    @layout = TestViewAttrLayout.new
  end

  it 'should get :button' do
    @layout.view
    button = @layout.button
    button.should.be.kind_of(UIButton)
  end

  it 'should return the same :button' do
    @layout.view
    button = @layout.button
    button.should == @layout.button
  end

  it 'should call layout if the view doesnt exist' do
    label = @layout.label
    label.should.be.kind_of(UILabel)
    label.should == @layout.label
  end

end
