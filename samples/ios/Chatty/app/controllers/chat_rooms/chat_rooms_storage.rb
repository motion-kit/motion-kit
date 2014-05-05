class ChatRoomsStorage

  def rooms_ref
    @rooms_ref ||= Chatty.rooms_ref
  end

  def listeners
    @listeners ||= []
  end

  def rooms
    @rooms ||= []
  end

  def get_rooms(&handler)
    listeners << rooms_ref.on(:added) do |snapshot|
      room = ChatRoom.new(snapshot.value)
      rooms << room
      handler.call(room)
    end
    listeners << rooms_ref.on(:removed) do |snapshot|
      room = rooms.find { |room| room.name = snapshot.value['name']}
      if room
        rooms.delete(room)
      end
      handler.call(room)
    end
  end

  def create_room(name, &and_then)
    room = ChatRoom.new('name' => name)
    Chatty.rooms_ref[name].setValue({
      name: name,
    }) do
      and_then.call(room)
    end
    return room
  end

  def off
    listeners.each do |listener|
      rooms_ref.off listener
    end
    @listeners = nil
    @rooms = nil
  end

end
