class ChatController < UIViewController

  def loadView
    @layout = ChatLayout.new
    self.view = @layout.view
  end

end
