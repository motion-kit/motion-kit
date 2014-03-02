class AppDelegate

  def applicationDidFinishLaunching(notification)
    @controller = TrackWindowController.alloc.init
    @controller.showWindow(self)
    @window = @controller.window
    @window.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @window.orderFrontRegardless
    buildMenu
  end

end
