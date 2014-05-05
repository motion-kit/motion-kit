class ChatStorage

  def initialize(room)
    @room = room
  end

  def chat_ref
    @chat_ref ||= Chatty.chat_ref[@room.name]
  end

  def entries
    @entries ||= []
  end

  def listeners
    @listeners ||= []
  end

  def get_chat(&handler)
    listeners << chat_ref.on(:added) do |snapshot|
      chat = Chat.new(snapshot.value)
      entries << chat
      handler.call(chat)
    end
  end

  def create_entry(content, from)
    chat = ChatRoom.new('content' => content, 'from' => from)
    chat_ref << {
      content: content,
      from: from,
      created: Time.new.to_i,
    }
    return chat
  end

  def off
    listeners.each do |listener|
      chat_ref.off listener
    end
    @listeners = nil
    @entries = nil
  end

end
