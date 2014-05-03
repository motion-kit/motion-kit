class LoginController < UIViewController

  def loadView
    @layout = LoginLayout.new
    self.view = @layout.view
  end

  def viewWillAppear(animated)
    super
    NSNotificationCenter.defaultCenter.addObserver(self,
            selector: 'keyboard_will_show:',
            name: UIKeyboardWillShowNotification,
            object: nil)
    NSNotificationCenter.defaultCenter.addObserver(self,
            selector: 'keyboard_will_hide:',
            name: UIKeyboardWillHideNotification,
            object: nil)
  end

  def viewWillDisappear(animated)
    super
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object:nil)
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object:nil)
  end

  def keyboard_will_show(notification)
    kbd_height = notification.userInfo[UIKeyboardFrameEndUserInfoKey].CGRectValue.size.height
    duration = notification[UIKeyboardAnimationDurationUserInfoKey]
    @layout.show_keyboard(duration, kbd_height)
  end

  def keyboard_will_hide(notification)
    duration = notification[UIKeyboardAnimationDurationUserInfoKey]
    @layout.hide_keyboard(duration)
  end

end
