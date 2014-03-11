
class AppDelegate
  def applicationDidFinishLaunching(notification)
    NSApp.mainMenu = MainMenu.new.menu
    NSApp.mainMenu.output

    @controller = WindowController.alloc.init
    @controller.showWindow(self)
    @controller.window.orderFrontRegardless
  end

end
