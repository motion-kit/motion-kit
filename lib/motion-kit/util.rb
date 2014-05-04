module MotionKit
  module_function

  def objective_c_method_name(str)
    str.split('_').inject([]) { |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
  end

  def camel_case(str)
    str.split('_').map(&:capitalize).join
  end

  def setter(method_name)
    "set#{method_name[0].capitalize}#{method_name[1..-1]}:"
  end

  def appearance_class
    @appearance_class ||= Class.new
  end

end
