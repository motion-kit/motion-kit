class ChatRoomsStorage

  class << self

    def rooms_ref
      @rooms_ref ||= Chatty.rooms_ref
    end

    def listeners
      @listeners ||= []
    end

    def get_rooms(&handler)
      listeners << rooms_ref.on(:child_added) do |snapshot|
        room = ChatRoom.new(snapshot.value)
        rooms << room
        handler.call(room)
      end
    end

    def rooms
      @rooms ||= []
    end

    def reset_rooms
      @rooms = nil
    end

    def create_room(name)
      Chatty.room_ref[name] = {
        name: name,
      }
    end

    def off
      listeners.each do |listener|
        rooms_ref.off listener
      end
    end

  end

end
