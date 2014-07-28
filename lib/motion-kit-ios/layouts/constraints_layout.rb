# @requires MotionKit::UIViewLayout
module MotionKit
  class UIViewLayout

    def content_compression_resistance_priority(value, for_axis: axis)
      axis = Constraint.axis_lookup(axis)
      target.setContentCompressionResistancePriority(value, forAxis: axis)
    end

    def compression_priority(value, for_axis: axis)
      content_compression_resistance_priority(value, for_axis: axis)
    end

    def content_hugging_priority(value, for_axis: axis)
      axis = Constraint.axis_lookup(axis)
      target.setContentHuggingPriority(value, forAxis: axis)
    end

    def hugging_priority(value, for_axis: axis)
      content_hugging_priority(value, for_axis: axis)
    end

  end
end
