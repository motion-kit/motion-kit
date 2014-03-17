describe TestRootMenu do

  before do
    @subject = TestRootMenu.new
    @subject.view
  end

  it 'should create a menu via "root"' do
    menu = @subject.menu
    menu.should.not == nil
    menu.should.be.kind_of(NSMenu)
    menu.title.should == 'Test Root'
  end

end
