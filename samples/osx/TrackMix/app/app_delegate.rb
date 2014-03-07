class AppDelegate

  def applicationDidFinishLaunching(notification)
    NSApp.mainMenu = MainMenu.new.menu

    @controller = TrackWindowController.alloc.init
    @controller.showWindow(self)
    @controller.window.orderFrontRegardless
  end

end
