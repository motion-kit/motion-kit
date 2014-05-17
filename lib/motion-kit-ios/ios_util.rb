module MotionKit
  module_function

  def appearance_class
    @appearance_klass ||= UIView.appearance.class
  end

  def base_view_class
    UIView
  end

  def default_view_class
    UIView
  end

  def color_class
    UIColor
  end

  def no_intrinsic_metric
    UIViewNoIntrinsicMetric
  end

end
