class AppDelegate

  def applicationDidFinishLaunching(notification)
    @controller = TrackWindowController.alloc.init
    @controller.showWindow(self)
    @window = @controller.window
    @window.orderFrontRegardless

    NSApp.mainMenu = MainMenu.new.menu
  end

end
