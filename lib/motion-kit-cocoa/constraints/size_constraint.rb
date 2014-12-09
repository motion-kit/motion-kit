# @requires MotionKit::CompoundConstraint
module MotionKit

  class SizeConstraint < CompoundConstraint

    def initialize(target, attribute=nil, relationship=:equal)
      super
      @attribute = [:width, :height]
      @attribute2 = [:width, :height]
    end

    def attribute=(value)
      raise NoMethodError.new("undefined method `#{:attribute=}' for #{self}:#{self.class}", :attribute=)
    end

    def attribute2=(value)
      raise NoMethodError.new("undefined method `#{:attribute2=}' for #{self}:#{self.class}", :attribute2=)
    end

    def constant=(constant)
      if constant.is_a?(Array)
        @constant = constant[0..1]
      elsif constant.is_a?(Hash)
        @constant = [0, 0]

        if constant.key?(:w)
          @constant[0] = constant[:w]
        elsif constant.key?(:width)
          @constant[0] = constant[:width]
        end

        if constant.key?(:h)
          @constant[1] = constant[:h]
        elsif constant.key?(:height)
          @constant[1] = constant[:height]
        end
      else
        @constant = [constant, constant]
      end

      self.update_constraint
    end

    def multiplier=(multiplier)
      if multiplier.is_a?(Array)
        @multiplier = multiplier[0..1]
      elsif multiplier.is_a?(Hash)
        @multiplier = [0, 0]

        if multiplier.key?(:w)
          @multiplier[0] = multiplier[:w]
        elsif multiplier.key?(:width)
          @multiplier[0] = multiplier[:width]
        end

        if multiplier.key?(:h)
          @multiplier[1] = multiplier[:h]
        elsif multiplier.key?(:height)
          @multiplier[1] = multiplier[:height]
        end
      else
        @multiplier = [multiplier, multiplier]
      end

      self.update_constraint
    end

    def plus(constant)
      if constant.is_a?(Array)
        self.constant[0] += constant[0]
        self.constant[1] += constant[1]
      elsif constant.is_a?(Hash)
        if constant.key?(:w)
          self.constant[0] += constant[:w]
        elsif constant.key?(:width)
          self.constant[0] += constant[:width]
        end

        if constant.key?(:h)
          self.constant[1] += constant[:h]
        elsif constant.key?(:height)
          self.constant[1] += constant[:height]
        end
      else
        self.constant[0] += constant
        self.constant[1] += constant
      end

      self.update_constraint
      self
    end

    def minus(constant)
      if constant.is_a?(Array)
        self.constant[0] -= constant[0]
        self.constant[1] -= constant[1]
      elsif constant.is_a?(Hash)
        if constant.key?(:w)
          self.constant[0] -= constant[:w]
        elsif constant.key?(:width)
          self.constant[0] -= constant[:width]
        end

        if constant.key?(:h)
          self.constant[1] -= constant[:h]
        elsif constant.key?(:height)
          self.constant[1] -= constant[:height]
        end
      else
        self.constant[0] -= constant
        self.constant[1] -= constant
      end

      self.update_constraint
      self
    end

    def times(multiplier)
      if multiplier.is_a?(Array)
        self.multiplier[0] *= multiplier[0]
        self.multiplier[1] *= multiplier[1]
      elsif multiplier.is_a?(Hash)
        if multiplier.key?(:w)
          self.multiplier[0] *= multiplier[:w]
        elsif multiplier.key?(:width)
          self.multiplier[0] *= multiplier[:width]
        end

        if multiplier.key?(:h)
          self.multiplier[1] *= multiplier[:h]
        elsif multiplier.key?(:height)
          self.multiplier[1] *= multiplier[:height]
        end
      else
        self.multiplier[0] *= multiplier
        self.multiplier[1] *= multiplier
      end

      self.update_constraint
      self
    end

    def divided_by(multiplier)
      if multiplier.is_a?(Array)
        self.multiplier[0] /= multiplier[0].to_f
        self.multiplier[1] /= multiplier[1].to_f
      elsif multiplier.is_a?(Hash)
        if multiplier.key?(:w)
          self.multiplier[0] /= multiplier[:w].to_f
        elsif multiplier.key?(:width)
          self.multiplier[0] /= multiplier[:width].to_f
        end

        if multiplier.key?(:h)
          self.multiplier[1] /= multiplier[:h].to_f
        elsif multiplier.key?(:height)
          self.multiplier[1] /= multiplier[:height].to_f
        end
      else
        self.multiplier[0] /= multiplier.to_f
        self.multiplier[1] /= multiplier.to_f
      end

      self.update_constraint
      self
    end

    def resolve_all(layout, view)
      @resolved ||= begin
        item = Constraint.view_lookup(layout, view, self.target)
        rel_item = Constraint.view_lookup(layout, view, self.relative_to)
        relationship = Constraint.relationship_lookup(self.relationship)

        [[:width, 0], [:height, 1]].map do |attr_name, index|
          attribute = Constraint.attribute_lookup(attr_name)
          nsconstraint = NSLayoutConstraint.constraintWithItem(item,
            attribute: attribute,
            relatedBy: relationship,
            toItem: rel_item,
            attribute: attribute,
            multiplier: self.multiplier[index],
            constant: self.constant[index]
            )

          if self.priority
            nsconstraint.priority = Constraint.priority_lookup(self.priority)
          end

          if self.identifier
            nsconstraint.setIdentifier(self.identifier)
          end

          nsconstraint
        end
      end
    end

  end

end
