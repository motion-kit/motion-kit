# @requires MotionKit::ConstraintsLayout
module MotionKit
  class ConstraintsLayout

    def content_compression_resistance_priority(value, for_orientation: orientation)
      orientation = Constraint.orientation_lookup(orientation)
    end

    # consistency with iOS methods:
    def content_compression_resistance_priority(value, for_axis: orientation)
      content_compression_resistance_priority(value, for_orientation: orientation)
    end

    def compression_priority(value, for_orientation: orientation)
      content_compression_resistance_priority(value, for_orientation: orientation)
    end

    # consistency with iOS methods:
    def compression_priority(value, for_axis: orientation)
      content_compression_resistance_priority(value, for_orientation: orientation)
    end

    def content_hugging_priority(value, for_orientation: orientation)
      orientation = Constraint.orientation_lookup(orientation)
    end

    # consistency with iOS methods:
    def content_hugging_priority(value, for_axis: orientation)
      content_hugging_priority(value, for_orientation: orientation)
    end

    def hugging_priority(value, for_orientation: orientation)
      content_hugging_priority(value, for_orientation: orientation)
    end

    # consistency with iOS methods:
    def hugging_priority(value, for_axis: orientation)
      content_hugging_priority(value, for_orientation: orientation)
    end

  end
end
