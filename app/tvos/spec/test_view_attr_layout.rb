class TestViewAttrLayout < MK::Layout
  view :button
  view :label
  view :text_field, :text_view

  def layout
    add UIButton, :button
    add UILabel, :label
    add UITextField, :text_field
    add UITextView, :text_view
  end

end
