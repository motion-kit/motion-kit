class ChatRoomsController < UIViewController

  def loadView
    @layout = ChatRoomsLayout.new
    self.view = @layout.view

    @table_view = @layout.table_view
    @layout.on_room_tapped do |room|
      room_tapped(room)
    end
    @layout.on_create_tapped do
      create_room_tapped
    end
  end

  def storage
    @storage ||= ChatRoomsStorage.new
  end

  def viewWillAppear(animated)
    super

    storage.get_rooms do |room|
      @layout.rooms = storage.rooms.sort do |room_a, room_b|
        room_a.name.downcase <=> room_b.name.downcase
      end
    end
  end

  def viewWillDisappear(animated)
    super

    storage.off
  end

  def create_room_tapped
    UIAlertView.alert(
      title: 'Create room',
      message: 'What should we call it?',
      buttons: {
        cancel: 'Cancel',
        save: 'Save',
      },
      style: :plain_text_input,
      ) do |button, room_name|
      if button == :save && ! room_name.empty?
        create_room_named(room_name)
      end
    end
  end

  def create_room_named(room_name)
    # show spinner
    storage.create_room(room_name) do |room|
      # hide spinner
      room_tapped(room)
    end
  end

  def room_tapped(room)
    chat_controller = ChatController.alloc.initWithRoom(room)
    self.navigationController << chat_controller
  end

end
