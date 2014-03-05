class AppDelegate

  def applicationDidFinishLaunching(notification)
    NSApp.mainMenu = MainMenu.new.menu

    @controller = TrackWindowController.alloc.init
    @controller.showWindow(self)
    @window = @controller.window
    @window.orderFrontRegardless
  end

end
