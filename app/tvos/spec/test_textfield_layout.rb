class TestTextFieldLayout < MK::Layout

  def layout
    add UITextField, :field
  end

  def field_style
    autocorrectionType UITextAutocorrectionTypeNo
    spellCheckingType UITextSpellCheckingTypeNo
    autocapitalizationType UITextAutocapitalizationTypeNone
  end

end
