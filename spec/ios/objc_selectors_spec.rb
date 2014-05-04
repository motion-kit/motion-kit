describe 'Obj-C Selectors' do

  it 'should work' do
    -> do
      layout = TestObjcSelectorsLayout.new
      layout.view
    end.should.not.raise
  end

end
