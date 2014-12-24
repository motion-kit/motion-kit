class MainController < UIViewController

  def dealloc
    NSLog("=============== main_controller.rb line #{__LINE__} ===============")
    super
  end

  def viewDidLoad
    @layout = MainLayout.new(root: self.view).build
  end

end
