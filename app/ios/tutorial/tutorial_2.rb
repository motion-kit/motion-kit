class TutorialTwoController < UIViewController
  include TutorialModule

  def viewDidLoad
    setup_nav('2', first: true)
  end

  def go_forward
    ctlr = TutorialThreeController.new
    self.navigationController.pushViewController(ctlr, animated: true)
  end

end
