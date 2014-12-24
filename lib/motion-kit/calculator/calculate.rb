# @requires MotionKit::ViewCalculator
module MotionKit
  module_function

  def calculate(view, dimension, amount, full_view=nil)
    ViewCalculator.calculate(view, dimension, amount, full_view)
  end

end
