class HelloViewController < UIViewController

  def loadView
    @layout = HelloLayout.new
    self.view = @layout.view
  end

  def viewWillAppear(animated)
    @layout.reapply!
  end

  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    @layout.reapply!
  end

end
