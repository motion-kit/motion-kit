class TestStyleable
  include MotionKit::Styleable

  attr :target

  def initialize(obj)
    @target = obj
  end

  def run_foo
    self.context(@target) do
      foo 'foo'
    end
  end

  def run_bar
    self.context(@target) do
      bar 'bar'
    end
  end

  def run_baz
    self.context(@target) do
      baz do
        quux 'quux'
      end
    end
  end

  def run_baz_baz
    self.context(@target) do
      baz_baz do
        quux 'quux'
      end
    end
  end

  def run_text
    self.context(@target) do
      text 'text'
    end
  end

  def run_background_color
    self.context(@target) do
      background_color UIColor.whiteColor
    end
  end

  def run_layer(radius)
    self.context(@target) do
      layer do
        corner_radius radius
      end
    end
  end

end


class TestStyleableFixture
  attr :foo
  attr :bar

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

  class Baz
    attr_accessor :quux
  end

end


class TestStyleableLabel < UILabel
  attr_accessor :bar
end

