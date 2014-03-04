describe TestCreateMenu do

  before do
    @subject = TestCreateMenu.new
  end

  it 'should create a menu via "create"' do
    menu = @subject.some_menu
    menu.should.not == nil
    menu.should.be.kind_of(NSMenu)
    menu.title.should == 'Test Create'
  end

end
