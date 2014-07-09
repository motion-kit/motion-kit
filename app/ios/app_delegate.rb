class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    # if you need to test a controller or something, add it here
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    ctlr = UIViewController.new
    @window.rootViewController = ctlr
    @window.makeKeyAndVisible

    true
  end
end
