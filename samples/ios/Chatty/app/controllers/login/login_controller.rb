class LoginController < UIViewController

  def loadView
    @layout = LoginLayout.new
    self.view = @layout.view

    @layout.submit_button.on :touch do
      submit_username
    end

    self.title = 'Chatty'
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
    curve = notification[UIKeyboardAnimationCurveUserInfoKey]
    @layout.show_keyboard(kbd_height, duration: duration, curve: curve)
  end

  def keyboard_will_hide(notification)
    duration = notification[UIKeyboardAnimationDurationUserInfoKey]
    curve = notification[UIKeyboardAnimationCurveUserInfoKey]
    @layout.hide_keyboard(duration: duration, curve: curve)
  end

  def submit_username
    username = @layout.username_field.text || ''
    unless username.empty?
      $username = username
      @layout.username_field.resignFirstResponder

      chatrooms_controller = ChatRoomsController.new
      navigationController.setViewControllers([chatrooms_controller], animated: true)
    end
  end

end
