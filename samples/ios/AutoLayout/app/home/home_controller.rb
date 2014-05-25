class HomeController < UIViewController

  def loadView
    super
    self.title = 'Autolayout Example'
    @layout = HomeLayout.new(root: self.view)
    @layout.top_layout_guide = self.topLayoutGuide
    @layout.build

    @label = @layout.label
    @button = @layout.button
    @switch = @layout.switch
    @segmented = @layout.segmented
  end

  def viewDidAppear(animated)
    super
  end

end
