class ChatLayout < MK::Layout
  view :chat
  view :input_field
  view :submit

  def initialize(room)
    @room = room
    super()
  end

  def layout
    background_color UIColor.whiteColor

    add UITableView, :chat
    add UIView, :text_container do
      add UITextField, :input_field
      add UIButton, :submit
    end
  end

  def entries
    @entries ||= []
  end

  def entries=(value)
    @entries = value
    chat.reloadData
  end

  def on_submit(&handler)
    @submit_handler = handler.weak!
  end

  def show_keyboard(kbd_height, options={})
    duration = options.fetch(:duration, 0.2)
    curve = options.fetch(:curve)
    context(:username_field) do
      @container_bottom.minus kbd_height

      UIView.animateWithDuration(duration, delay: 0, options: curve, animations: -> do
        self.view.layoutIfNeeded
      end, completion: nil)
    end
  end

  def hide_keyboard(options={})
    duration = options.fetch(:duration, 0.2)
    curve = options.fetch(:curve)
    context(:username_field) do
      @container_bottom.constant = 0
      UIView.animateWithDuration(duration, delay: 0, options: curve, animations: -> do
        self.view.layoutIfNeeded
      end, completion: nil)
    end
  end

  def chat_style
    delegate self
    dataSource self
    backgroundColor :clear.uicolor
    separatorStyle UITableViewCellSeparatorStyleNone

    registerClass(ChatCell, forCellReuseIdentifier: ChatCell::ID)

    constraints do
      top.equals(:superview)
      left.equals(:superview)
      right.equals(:superview)
      above :text_container
    end
  end

  def text_container_style
    constraints do
      below :chat
      height 40
      left.equals(:superview)
      right.equals(:superview)
      @container_bottom = bottom.equals(:superview)
    end
  end

  def input_field_style
    placeholder '…'
    constraints do
      left.equals(:superview)
      left_of :submit
      top.equals(:superview)
      bottom.equals(:superview)
    end
  end

  def reset_input_field
    input_field.text = ''
    input_field.resignFirstResponder
  end

  def submit_style
    title 'Submit'
    title_color UIColor.blackColor

    constraints do
      right.equals(:superview)
      center_y.equals(:superview)
    end

    target.on :touch do
      @submit_handler.call if @submit_handler
    end
  end

  def tableView(table_view, numberOfRowsInSection: section)
    entries.length
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    entry = self.entries[index_path.row]
    context table_view.dequeueReusableCellWithIdentifier(ChatCell::ID) do
      content entry.content
      from    entry.from
      created entry.created
    end
  end

end


class ChatCell < UITableViewCell
  ID = 'ChatCell'

  def initWithStyle(style, reuseIdentifier: id)
    super(UITableViewCellStyleSubtitle, reuseIdentifier: id)
  end

  def content=(value)
    textLabel.text = value
  end

  def from=(value)
    @from = value
    _update_detail
  end

  def created=(value)
    @created = value
    _update_detail
  end

  def _update_detail
    if @from && @created
      text = "by #{@from} at #{@created.string_with_style(NSDateFormatterShortStyle)}"
    elsif @from
      text = "by #{@from}"
    elsif @created
      text = "at #{@created.string_with_style(NSDateFormatterShortStyle)}"
    else
      text = ''
    end
    detailTextLabel.text = text
  end

end
