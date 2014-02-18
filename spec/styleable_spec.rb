describe "Styleable module" do

  describe "Pure ruby object" do

    before do
      @subject = TestStyleable.new(TestStyleableFixture.new)
    end

    it 'should set foo (setFoo)' do
      @subject.run_foo
      @subject.v.foo.should == 'foo'
    end

    it 'should set bar (bar=)' do
      @subject.run_bar
      @subject.v.bar.should == 'bar'
    end

    it 'should assign quux (baz.quux, attr_accessor) with baz as context' do
      @subject.run_baz
      @subject.v.baz.quux.should == 'quux'
    end

    it 'should assign quux (bazBaz.quux, attr_accessor) with baz_baz as context' do
      @subject.run_baz_baz
      @subject.v.bazBaz.quux.should == 'quux'
    end

  end

  describe "Objective-C object" do

    before do
      @subject = TestStyleable.new(TestStyleableLabel.new)
    end

    it 'should set text (setText)' do
      @subject.run_text
      @subject.v.text.should == 'text'
    end

    it 'should set bar (bar=)' do
      @subject.run_bar
      @subject.v.bar.should == 'bar'
    end

    it 'should set background_color (setBackgroundColor)' do
      @subject.run_background_color
      @subject.v.backgroundColor.should == UIColor.whiteColor
    end

    it 'should assign cornerRadius (layer.corner_radius) with layer as context' do
      @subject.run_layer(5)
      @subject.v.layer.cornerRadius.should == 5
    end
  end

end
