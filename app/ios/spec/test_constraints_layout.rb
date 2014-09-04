class TestConstraintsHelpers < MK::Layout

  def layout
    add UIView, :a
    add UIView, :b
    add UIView, :c
  end

  def a_style
    constraints do
      x 10
      y 10
      w 100
      h 100
    end
  end

  def b_style
    constraints do
      x.equals(:a).plus(10)
      y.equals(:a).plus(10)
      width.equals(:a).plus(10)
      height.equals(:a).plus(10)
    end
  end

end
