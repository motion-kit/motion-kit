class TestViewAttrLayout < MK::Layout
  view :button
  view :label

  def layout
    add UIButton, :button
    add UILabel, :label
  end

end
