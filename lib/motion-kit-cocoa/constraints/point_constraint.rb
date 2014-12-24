# @requires MotionKit::CompoundConstraint
module MotionKit

  class PointConstraint < CompoundConstraint

    def constant=(constant)
      if constant.is_a?(Array)
        @constant = constant[0..1]
      elsif constant.is_a?(Hash)
        @constant = [0, 0]

        if constant.key?(:x)
          @constant[0] = constant[:x]
        end

        if constant.key?(:y)
          @constant[1] = constant[:y]
        end
      else
        @constant = [constant, constant]
      end

      self.relative_to ||= :superview
      self.update_constraint
    end

    def multiplier=(multiplier)
      if multiplier.is_a?(Array)
        @multiplier = multiplier[0..1]
      elsif multiplier.is_a?(Hash)
        @multiplier = [0, 0]

        if multiplier.key?(:x)
          @multiplier[0] = multiplier[:x]
        end

        if multiplier.key?(:y)
          @multiplier[1] = multiplier[:y]
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
        if constant.key?(:x)
          self.constant[0] += constant[:x]
        elsif constant.key?(:right)
          self.constant[0] += constant[:right]
        elsif constant.key?(:left)
          self.constant[0] -= constant[:left]
        end

        if constant.key?(:y)
          self.constant[1] += constant[:y]
        elsif constant.key?(:up)
          self.constant[1] += constant[:up]
        elsif constant.key?(:down)
          self.constant[1] -= constant[:down]
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
        if constant.key?(:x)
          self.constant[0] -= constant[:x]
        elsif constant.key?(:right)
          self.constant[0] -= constant[:right]
        elsif constant.key?(:left)
          self.constant[0] += constant[:left]
        end

        if constant.key?(:y)
          self.constant[1] -= constant[:y]
        elsif constant.key?(:up)
          self.constant[1] -= constant[:up]
        elsif constant.key?(:down)
          self.constant[1] += constant[:down]
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
        if multiplier.key?(:x)
          self.multiplier[0] *= multiplier[:x]
        end

        if multiplier.key?(:y)
          self.multiplier[1] *= multiplier[:y]
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
        if multiplier.key?(:x)
          self.multiplier[0] /= multiplier[:x].to_f
        end

        if multiplier.key?(:y)
          self.multiplier[1] /= multiplier[:y].to_f
        end
      else
        self.multiplier[0] /= multiplier.to_f
        self.multiplier[1] /= multiplier.to_f
      end

      self.update_constraint
      self
    end

    def update_constraint
      if @resolved
        [0, 1].each do |index|
          constraint = @resolved[index]
          constraint.constant = self.constant[index]
        end
      end
    end

    def resolve_all(layout, view)
      @resolved ||= begin
        item = Constraint.view_lookup(layout, view, self.target)
        rel_item = Constraint.view_lookup(layout, view, self.relative_to)
        relationship = Constraint.relationship_lookup(self.relationship)

        [0, 1].map do |index|
          attribute = Constraint.attribute_lookup(self.attribute[index])
          mul = self.multiplier[index]
          const = self.constant[index]

          nsconstraint = NSLayoutConstraint.constraintWithItem(item,
            attribute: attribute,
            relatedBy: relationship,
            toItem: rel_item,
            attribute: attribute,
            multiplier: mul,
            constant: const
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
