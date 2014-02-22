describe "Layout setters" do

  describe "Pure ruby object" do

    before do
      @subject = TestSetters.new(TestSettersFixture.new)
    end

    it 'should set foo (setFoo)' do
      @subject.run_foo
      @subject.target.foo.should == 'foo'
    end

    it 'should set bar (bar=)' do
      @subject.run_bar
      @subject.target.bar.should == 'bar'
    end

    it 'should assign quux (baz.quux, attr_accessor) with baz as context' do
      @subject.run_baz
      @subject.target.baz.quux.should == 'quux'
    end

    it 'should assign quux (bazBaz.quux, attr_accessor) with baz_baz as context' do
      @subject.run_baz_baz
      @subject.target.bazBaz.quux.should == 'quux'
    end

  end

  describe "Objective-C object" do

    before do
      @subject = TestSetters.new(TestSettersLabel.new)
    end

    it 'should set text (setText)' do
      @subject.run_text
      @subject.target.text.should == 'text'
    end

    it 'should set bar (bar=)' do
      @subject.run_bar
      @subject.target.bar.should == 'bar'
    end

    it 'should set background_color (setBackgroundColor)' do
      @subject.run_background_color
      @subject.target.backgroundColor.should == UIColor.whiteColor
    end

    it 'should assign cornerRadius (layer.corner_radius) with layer as context' do
      @subject.run_layer(5)
      @subject.target.layer.cornerRadius.should == 5
    end
  end

end
