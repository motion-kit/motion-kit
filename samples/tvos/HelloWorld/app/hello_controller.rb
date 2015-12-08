class HelloViewController < UIViewController

  def loadView
    @layout   = HelloLayout.new
    self.view = @layout.view
    @button   = @layout.button
    @label    = @layout.label
    @button.addTarget(self, action: "button_pressed", forControlEvents: UIControlEventPrimaryActionTriggered)
  end

  def viewWillAppear(animated)
    @layout.reapply!
  end
  
  def button_pressed
    @label.text = "Welcome to MotionKit!"
    @layout.reapply!
  end

end
