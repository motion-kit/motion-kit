module MotionKit
  module_function

  def objective_c_method_name(str)
    str.split('_').inject([]) { |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
  end

  def camel_case(str)
    str.split('_').map(&:capitalize).join
  end

  def appearance_class
    @appearance_klass ||= UIView.appearance.class
  end

end
