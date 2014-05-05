class LoginLayout < MK::Layout
  view :username_field
  view :submit_button

  def layout
    background_color UIColor.blackColor
    add UIView, :background do
      add UITextField, :username_field
      add UIButton, :submit_button
    end
  end

  def show_keyboard(kbd_height, options={})
    duration = options.fetch(:duration, 0.2)
    curve = options.fetch(:curve)
    context(:username_field) do
      @bg_bottom.minus kbd_height

      UIView.animateWithDuration(duration, delay: 0, options: curve, animations: -> do
        self.view.layoutIfNeeded
      end, completion: nil)
    end
  end

  def hide_keyboard(options={})
    duration = options.fetch(:duration, 0.2)
    curve = options.fetch(:curve)
    context(:username_field) do
      @bg_bottom.constant = -10
      UIView.animateWithDuration(duration, delay: 0, options: curve, animations: -> do
        self.view.layoutIfNeeded
      end, completion: nil)
    end
  end

  def background_style
    initial do
      layer do
        corner_radius 10
      end
      background_color UIColor.whiteColor

      constraints do
        x 10
        right -10
        height 100
        @bg_bottom = bottom -10
      end
    end
  end

  def username_field_style
    initial do
      placeholder 'username'

      autocorrectionType UITextAutocorrectionTypeNo
      spellCheckingType UITextSpellCheckingTypeNo
      autocapitalizationType UITextAutocapitalizationTypeNone

      constraints do
        left 10
        right -10
        top 10
      end

      delegate self
    end
  end

  def submit_button_style
    initial do
      title 'Submit'
      title_color UIColor.blackColor

      constraints do
        right -8
        bottom -8
      end
    end
  end

end
