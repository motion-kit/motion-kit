class ChatRoomsLayout < MK::Layout
  ROOMS_SECTION = 0
  CREATE_ROOM_SECTION = 1

  view :table_view

  def layout
    background_color UIColor.blackColor
    @table_view = add UITableView, :table_view
  end

  def rooms
    @rooms ||= []
  end

  def rooms=(value)
    @rooms = value
    table_view.reloadData
  end

  def on_room_tapped(&handler)
    @room_handler = handler.weak!
  end

  def on_create_tapped(&handler)
    @create_handler = handler.weak!
  end

  def table_view_style
    delegate self
    dataSource self
    frame :full
    backgroundColor :clear.uicolor
    separatorStyle UITableViewCellSeparatorStyleNone

    registerClass(RoomsCell, forCellReuseIdentifier: RoomsCell::ID)
    registerClass(CreateRoomCell, forCellReuseIdentifier: CreateRoomCell::ID)
  end

  def numberOfSectionsInTableView(table_view)
    2
  end

  def tableView(table_view, numberOfRowsInSection: section)
    if section == ROOMS_SECTION
      self.rooms.length
    else
      1
    end
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    if index_path.section == ROOMS_SECTION
      room = self.rooms[index_path.row]
      context table_view.dequeueReusableCellWithIdentifier(RoomsCell::ID) do
        name room.name
      end
    else
      table_view.dequeueReusableCellWithIdentifier(CreateRoomCell::ID)
    end
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    table_view.deselectRowAtIndexPath(index_path, animated: true)

    if index_path.section == ROOMS_SECTION
      room = self.rooms[index_path.row]
      @room_handler.call(room) if @room_handler
    else
      @create_handler.call if @create_handler
    end
  end

end


class RoomsCell < UITableViewCell
  ID = 'RoomsCell'

  def initWithStyle(style, reuseIdentifier: id)
    super.tap do
    end
  end

  def name=(value)
    textLabel.text = value
  end

end


class CreateRoomCell < UITableViewCell
  ID = 'CreateRoomCell'

  def initWithStyle(style, reuseIdentifier: id)
    super.tap do
      textLabel.text = 'Create new room'
    end
  end

end
