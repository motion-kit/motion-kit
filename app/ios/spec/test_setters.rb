class TestSetters < MK::Layout
  attr :target

  def initialize(obj)
    @target = obj
    super(nil, obj)
  end

  def run_foo
    foo 'foo'
  end

  def run_bar
    bar 'bar'
  end

  def run_setter
    setter 'setter'
  end

  def run_baz
    baz do
      quux 'quux'
    end
  end

  def run_baz_baz
    baz_baz do
      quux 'quux'
    end
  end

  def run_text
    text 'text'
  end

  def run_background_color
    background_color UIColor.whiteColor
  end

  def run_layer(radius)
    layer do
      corner_radius radius
    end
  end

end


class TestSettersFixture
  attr :foo
  attr :bar
  attr :setter

  def setFoo(value)
    @foo = value
  end

  def bar=(value)
    @bar = value
  end

  def baz
    @baz ||= Baz.new
  end

  def bazBaz
    @baz_baz ||= Baz.new
  end

  def setter(value=nil)
    if value.nil?
      @setter
    else
      @setter = value
    end
  end

  class Baz
    attr_accessor :quux
  end

end


class TestSettersLabel < UILabel
  attr_accessor :bar
end

