class TestButtonLayout < MK::Layout
  TITLE = 'button title'
  HIGHLIGHTED_TITLE = 'button highlighted title'
  IMAGE = UIImage.new
  HIGHLIGHTED_IMAGE = UIImage.new

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
      font UIFont.systemFontOfSize(UIFont.systemFontSize)
    end

    titleLabel do
      textAlignment NSTextAlignmentCenter
    end
  end

end

