class TestPrevNextLayout < MK::Layout
  attr :first_row
  attr :second_row
  attr :third_row

  def layout
    @first_row = add(UIView, :row)
    @second_row = add(UIView, :row)
    @third_row = add(UIView, :row)
  end

end
