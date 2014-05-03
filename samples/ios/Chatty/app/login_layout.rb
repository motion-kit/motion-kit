class LoginLayout < MK::Layout

  def layout
    add UIView, :background do
      add UITextField, :username_field
      add UIButton, :submit_button
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

  def show_keyboard(duration, kbd_height)
    context(:username_field) do
      @bg_bottom.minus kbd_height

      UIView.animateWithDuration(duration, animations: -> do
        self.view.layoutIfNeeded
      end)
    end
  end

  def hide_keyboard(duration)
    context(:username_field) do
      @bg_bottom.constant = -10
      UIView.animateWithDuration(duration, animations: -> do
        self.view.layoutIfNeeded
      end)
    end
  end

  def username_field_style
    initial do
      placeholder 'username'

      constraints do
        left 10
        right -10
        top 10
      end
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
