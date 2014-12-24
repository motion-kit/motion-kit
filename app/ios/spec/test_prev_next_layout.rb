class TestPrevNextLayout < MK::Layout
  attr :first_row
  attr :second_row
  attr :third_row

  def layout
    @first_row = add(UIView, :row)
    @second_row = add(UIView, :row)
    @third_row = add(UIView, :row)
  end

  def from_search
    create(UIView) do
      @first_row = add(UIView, :row)
      @second_row = add(UIView, :row) do
        add(UIView, :start_here)
      end
      @third_row = add(UIView, :row)
    end
  end

  def from_symbol_search
    create(UIView) do
      @first_row = add(UIView, :first_row)
      @second_row = add(UIView, :second_row) do
        add(UIView, :start_here)
      end
      @third_row = add(UIView, :third_row)
    end
  end

end
