# @requires MotionKit::ViewCalculator
module MotionKit
  module_function

  def calculate(view, dimension, amount, full_view=nil)
    ViewCalculator.new.calculate(view, dimension, amount, full_view)
  end

end
