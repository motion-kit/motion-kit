class AppDelegate
  def application(application, didFinishLaunchingWithOptions: options)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    main_ctlr = MainController.new
    view_ctlr = UIViewController.new
    nav_ctlr = UINavigationController.alloc.initWithRootViewController(view_ctlr)
    nav_ctlr.pushViewController(main_ctlr, animated: false)
    @window.rootViewController = nav_ctlr
    @window.makeKeyAndVisible

    true
  end
end
