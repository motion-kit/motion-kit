# @requires MotionKit::NSViewHelpers
module MotionKit
  class NSViewHelpers

    def content_compression_resistance_priority(value, for_orientation: orientation)
      orientation = Constraint.orientation_lookup(orientation)
      target.setContentCompressionResistancePriority(value, forOrientation: axis)
    end

    def compression_priority(value, for_orientation: orientation)
      content_compression_resistance_priority(value, for_orientation: orientation)
    end

    def content_hugging_priority(value, for_orientation: orientation)
      orientation = Constraint.orientation_lookup(orientation)
      target.setContentHuggingPriority(value, forOrientation: axis)
    end

    def hugging_priority(value, for_orientation: orientation)
      content_hugging_priority(value, for_orientation: orientation)
    end

    ##|
    ##|  Aliases for consistency with iOS versions:
    ##|

    def content_compression_resistance_priority(value, for_axis: orientation)
      content_compression_resistance_priority(value, for_orientation: orientation)
    end

    def compression_priority(value, for_axis: orientation)
      content_compression_resistance_priority(value, for_orientation: orientation)
    end

    def content_hugging_priority(value, for_axis: orientation)
      content_hugging_priority(value, for_orientation: orientation)
    end

    def hugging_priority(value, for_axis: orientation)
      content_hugging_priority(value, for_orientation: orientation)
    end

  end
end
