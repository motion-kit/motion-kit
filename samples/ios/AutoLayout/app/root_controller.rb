class RootController < UIViewController

  def loadView
    self.title = 'Autolayout Example'
    @layout = HomeLayout.new
    self.view = @layout.view

    @label = @layout.label
    @button = @layout.button
    @switch = @layout.switch
  end

  def updateViewConstraints
    @layout.add_constraints(self)
    super
  end

end
