class ChatRoomsController < UIViewController

  def loadView
    @layout = ChatRoomsLayout.new
    self.view = @layout.view

    @table_view = @layout.table_view
  end

  def storage
    @storage ||= ChatRoomsStorage.new
  end

  def viewWillAppear(animated)
    super

    storage.get_rooms do |room|
      @table_view.reloadData
    end
  end

  def viewWillDisappear(animated)
    super

    storgae.reset_rooms
  end

end
