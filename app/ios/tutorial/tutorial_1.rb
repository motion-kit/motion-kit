class TutorialOneController < UIViewController
  include TutorialModule

  def viewDidLoad
    setup_nav('1', first: true)
  end

  def go_forward
    ctlr = TutorialTwoController.new
    self.navigationController.pushViewController(ctlr, animated: true)
  end

end
