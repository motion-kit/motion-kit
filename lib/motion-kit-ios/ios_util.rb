module MotionKit
  module_function

  def appearance_class
    @appearance_klass ||= UIView.appearance.class
  end

end
