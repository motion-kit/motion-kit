class TestButtonLayout < MK::Layout
  TITLE = 'button title'
  HIGHLIGHTED_TITLE = 'button highlighted title'
  IMAGE = UIImage.new
  HIGHLIGHTED_IMAGE = UIImage.new
  FONT = 'Avenir-Roman'
  SIZE = 20

  def layout
    add UIButton, :button
    add UIButton, :styled_button
  end

  def button_style
    title TITLE
    title HIGHLIGHTED_TITLE, state: UIControlStateHighlighted

    image IMAGE
    image HIGHLIGHTED_IMAGE, state: UIControlStateHighlighted

    title_label do
      font UIFont.fontWithName(FONT, size: SIZE)
    end

    titleLabel do
      textAlignment NSTextAlignmentCenter
    end
  end

end

