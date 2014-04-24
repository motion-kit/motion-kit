class TestButtonLayout < MK::Layout
  TITLE = 'button title'
  IMAGE = UIImage.new

  def layout
    add UIButton, :button
  end

  def button_style
    title TITLE
    image IMAGE
  end

end

