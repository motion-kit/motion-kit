class ChatController < UIViewController

  def initWithRoom(room)
    init.tap do
      @room = room
    end
  end

  def loadView
    self.title = @room.name
    @layout = ChatLayout.new(@room)
    self.view = @layout.view

    @layout.on_submit do
      submit_chat
    end
  end

  def storage
    @storage ||= ChatStorage.new(@room)
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

    storage.get_chat do |chat|
      @layout.entries = storage.entries
    end
  end

  def viewWillDisappear(animated)
    super
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object:nil)
    NSNotificationCenter.defaultCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object:nil)

    storage.off
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

  def submit_chat
    entry = @layout.input_field.text || ''
    unless entry.empty?
      storage.create_entry(entry, $username)
      @layout.reset_input_field
    end
  end

end
