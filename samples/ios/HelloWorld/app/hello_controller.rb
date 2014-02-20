class HelloViewController < UIViewController

  def loadView
    @layout = HelloLayout.new
    self.view = @layout.view
  end

  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    @layout.reapply!
  end

end
