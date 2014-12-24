class CustomLabel < UILabel
  attr_accessor :attributes
end


class CustomLabelHelpers < MK::UIViewHelpers
  targets CustomLabel

  def text(value)
    if @attributes
      text = NSAttributedString.alloc.initWithString(value.to_s, attributes: @attributes)
      target.attributedText = text
    else
      target.text = value.to_s
    end
  end

end


class TestCustomLayout < MK::Layout

  def layout
    root CustomLabel do
      attributes NSFontAttributeName => UIFont.fontWithName('Avenir-Roman', size: 10)
      text 'custom text'
    end
  end

end


