module MotionKit
  class Constraint
    attr_accessor :target
    attr_accessor :attribute
    attr_accessor :relationship
    attr_accessor :relative_to
    attr_accessor :attribute2
    attr_accessor :multiplier
    attr_accessor :constant
    attr_accessor :priority
    attr_accessor :identifier

    Priorities = {
      required: 1000,  # NSLayoutPriorityRequired
      high: 750,  # NSLayoutPriorityDefaultHigh
      medium: 500,
      low: 250,  # NSLayoutPriorityDefaultLow
    }
    Relationships = {
      equal: NSLayoutRelationEqual,
      lte: NSLayoutRelationLessThanOrEqual,
      gte: NSLayoutRelationGreaterThanOrEqual,
    }
    Attributes = {
      none: NSLayoutAttributeNotAnAttribute,
      left: NSLayoutAttributeLeft,
      right: NSLayoutAttributeRight,
      top: NSLayoutAttributeTop,
      bottom: NSLayoutAttributeBottom,
      leading: NSLayoutAttributeLeading,
      trailing: NSLayoutAttributeTrailing,
      width: NSLayoutAttributeWidth,
      height: NSLayoutAttributeHeight,
      center_x: NSLayoutAttributeCenterX,
      center_y: NSLayoutAttributeCenterY,
      baseline: NSLayoutAttributeBaseline,
    }

    def initialize(target, attribute=nil, relationship=:equal)
      @target = target
      @attribute = attribute
      @attribute2 = attribute
      @relationship = relationship
      @multiplier = 1
      @constant = 0
      @priority = nil
    end

    def equals(target, attribute2=nil)
      @relationship ||= :equal
      if constant?(target)
        @constant = target
      else
        @relative_to = target
        if attribute2
          @attribute2 = attribute2
        end
      end
      self
    end
    alias is_equal_to equals

    def lte(target, attribute2=nil)
      @relationship ||= :lte
      if constant?(target)
        @constant = target
      else
        @relative_to = target
        if attribute2
          @attribute2 = attribute2
        end
      end
      self
    end
    alias is_at_most lte

    def gte(target, attribute2=nil)
      @relationship ||= :gte
      if constant?(target)
        @constant = target
      else
        @relative_to = target
        if attribute2
          @attribute2 = attribute2
        end
      end
      self
    end
    alias is_at_least gte

    def times(multiplier)
      @multiplier *= multiplier
      self
    end

    def divided_by(multiplier)
      times 1.0/multiplier
    end

    # If no relationship has been set, the "use case" here is:
    #
    #     c.plus(10).equals(:view, :x)
    #
    # Which is the same as
    #
    #     c.equals(:view, :x).minus(10)
    def plus(constant)
      unless @relationship
        constant = -constant
      end
      @constant += constant
      self
    end

    def minus(constant)
      plus -constant
    end

    def priority(priority=nil)
      return @priority if priority.nil?

      @priority = priority
      self
    end

    def identifier(identifier=nil)
      return @identifier if identifier.nil?

      @identifier = identifier
      self
    end

    def resolve_all(layout)
      @resolved ||= begin
        item = view_lookup(layout, self.target)
        rel_item = view_lookup(layout, self.relative_to)

        nsconstraint = NSLayoutConstraint.constraintWithItem(item,
          attribute: attribute_lookup(self.attribute),
          relatedBy: relationship_lookup(self.relationship),
          toItem: rel_item,
          attribute: attribute_lookup(self.attribute2),
          multiplier: self.multiplier,
          constant: self.constant
          )

        if @priority
          nsconstraint.priority = priority_lookup(self.priority)
        end

        if @identifier
          nsconstraint.setIdentifier(@identifier)
        end

        [nsconstraint]
      end
    end

private
    def view_lookup(layout, target)
      if ! target || target.is_a?(MotionKit.base_view_class)
        target
      else
        layout.get(target)
      end
    end

    def attribute_lookup(attribute)
      if attribute.is_a? Fixnum
        return attribute
      end

      unless Attributes.key? attribute
        raise "Unsupported attribute #{attribute.inspect}"
      end

      Attributes[attribute]
    end

    def priority_lookup(priority)
      if priority.is_a? Fixnum
        return priority
      end

      unless Priorities.key? priority
        raise "Unsupported priority #{priority.inspect}"
      end

      Priorities[priority]
    end

    def relationship_lookup(relationship)
      if relationship.is_a? Fixnum
        return relationship
      end

      unless Relationships.key? relationship
        raise "Unsupported relationship #{relationship.inspect}"
      end

      Relationships[relationship]
    end

    def attribute_reverse(attribute)
      Attributes.key(attribute) || :none
    end

    def relationship_reverse(relationship)
      Relationships.key(relationship)
    end

    def constant?(value)
      value.is_a?(Numeric) || value.is_a?(Hash) || value.is_a?(Array)
    end

  end

  class CompoundConstraint < Constraint

    def initialize(target, attribute=nil, relationship=:equal)
      super
      @constant = [0, 0]
      @multiplier = [1, 1]
    end

    def constant=(constant)
      @constant = [0, 0]
      self.plus(constant)
    end

    def multiplier=(multiplier)
      @multiplier = [1, 1]
      self.times(multiplier)
    end

  end

  class SizeConstraint < CompoundConstraint

    def initialize(target, attribute=nil, relationship=:equal)
      super
      @attribute = [:width, :height]
      @attribute2 = [:width, :height]
    end

    def attribute=(value)
      raise NoMethodError.new(:attribute)
    end

    def attribute2=(value)
      raise NoMethodError.new(:attribute2)
    end

    def plus(constant)
      if constant.is_a?(Array)
        @constant[0] += constant[0]
        @constant[1] += constant[1]
      elsif constant.is_a?(Hash)
        if constant.key?(:w)
          @constant[0] += constant[:w]
        elsif constant.key?(:width)
          @constant[0] += constant[:width]
        end

        if constant.key?(:h)
          @constant[1] += constant[:h]
        elsif constant.key?(:height)
          @constant[1] += constant[:height]
        end
      else
        @constant[0] += constant
        @constant[1] += constant
      end

      self
    end

    def minus(constant)
      if constant.is_a?(Array)
        @constant[0] -= constant[0]
        @constant[1] -= constant[1]
      elsif constant.is_a?(Hash)
        if constant.key?(:w)
          @constant[0] -= constant[:w]
        elsif constant.key?(:width)
          @constant[0] -= constant[:width]
        end

        if constant.key?(:h)
          @constant[1] -= constant[:h]
        elsif constant.key?(:height)
          @constant[1] -= constant[:height]
        end
      else
        @constant[0] -= constant
        @constant[1] -= constant
      end

      self
    end

    def times(multiplier)
      if multiplier.is_a?(Array)
        @multiplier[0] *= multiplier[0]
        @multiplier[1] *= multiplier[1]
      elsif multiplier.is_a?(Hash)
        if multiplier.key?(:w)
          @multiplier[0] *= multiplier[:w]
        elsif multiplier.key?(:width)
          @multiplier[0] *= multiplier[:width]
        end

        if multiplier.key?(:h)
          @multiplier[1] *= multiplier[:h]
        elsif multiplier.key?(:height)
          @multiplier[1] *= multiplier[:height]
        end
      else
        @multiplier[0] *= multiplier
        @multiplier[1] *= multiplier
      end

      self
    end

    def divided_by(multiplier)
      if multiplier.is_a?(Array)
        @multiplier[0] /= multiplier[0].to_f
        @multiplier[1] /= multiplier[1].to_f
      elsif multiplier.is_a?(Hash)
        if multiplier.key?(:w)
          @multiplier[0] /= multiplier[:w].to_f
        elsif multiplier.key?(:width)
          @multiplier[0] /= multiplier[:width].to_f
        end

        if multiplier.key?(:h)
          @multiplier[1] /= multiplier[:h].to_f
        elsif multiplier.key?(:height)
          @multiplier[1] /= multiplier[:height].to_f
        end
      else
        @multiplier[0] /= multiplier.to_f
        @multiplier[1] /= multiplier.to_f
      end

      self
    end

    def resolve_all(layout)
      @resolved ||= begin
        item = view_lookup(layout, self.target)
        rel_item = view_lookup(layout, self.relative_to)

        [[:width, 0], [:height, 1]].map do |attribute, index|
          nsconstraint = NSLayoutConstraint.constraintWithItem(item,
            attribute: attribute_lookup(attribute),
            relatedBy: relationship_lookup(self.relationship),
            toItem: rel_item,
            attribute: attribute_lookup(attribute),
            multiplier: self.multiplier[index],
            constant: self.constant[index]
            )

          if @priority
            nsconstraint.priority = priority_lookup(self.priority)
          end

          if @identifier
            nsconstraint.setIdentifier(@identifier)
          end

          nsconstraint
        end
      end
    end

  end

  class PointConstraint < CompoundConstraint

    def plus(constant)
      if constant.is_a?(Array)
        @constant[0] += constant[0]
        @constant[1] += constant[1]
      elsif constant.is_a?(Hash)
        if constant.key?(:x)
          @constant[0] += constant[:x]
        elsif constant.key?(:right)
          @constant[0] += constant[:right]
        elsif constant.key?(:left)
          @constant[0] -= constant[:left]
        end

        if constant.key?(:y)
          @constant[1] += constant[:y]
        elsif constant.key?(:up)
          @constant[1] += constant[:up]
        elsif constant.key?(:down)
          @constant[1] -= constant[:down]
        end
      else
        @constant[0] += constant
        @constant[1] += constant
      end

      self
    end

    def minus(constant)
      if constant.is_a?(Array)
        @constant[0] -= constant[0]
        @constant[1] -= constant[1]
      elsif constant.is_a?(Hash)
        if constant.key?(:x)
          @constant[0] -= constant[:x]
        elsif constant.key?(:right)
          @constant[0] -= constant[:right]
        elsif constant.key?(:left)
          @constant[0] += constant[:left]
        end

        if constant.key?(:y)
          @constant[1] -= constant[:y]
        elsif constant.key?(:up)
          @constant[1] -= constant[:up]
        elsif constant.key?(:down)
          @constant[1] += constant[:down]
        end
      else
        @constant[0] -= constant
        @constant[1] -= constant
      end

      self
    end

    def times(multiplier)
      if multiplier.is_a?(Array)
        @multiplier[0] *= multiplier[0]
        @multiplier[1] *= multiplier[1]
      elsif multiplier.is_a?(Hash)
        if multiplier.key?(:x)
          @multiplier[0] *= multiplier[:x]
        end

        if multiplier.key?(:y)
          @multiplier[1] *= multiplier[:y]
        end
      else
        @multiplier[0] *= multiplier
        @multiplier[1] *= multiplier
      end

      self
    end

    def divided_by(multiplier)
      if multiplier.is_a?(Array)
        @multiplier[0] /= multiplier[0].to_f
        @multiplier[1] /= multiplier[1].to_f
      elsif multiplier.is_a?(Hash)
        if multiplier.key?(:x)
          @multiplier[0] /= multiplier[:x].to_f
        end

        if multiplier.key?(:y)
          @multiplier[1] /= multiplier[:y].to_f
        end
      else
        @multiplier[0] /= multiplier.to_f
        @multiplier[1] /= multiplier.to_f
      end

      self
    end

    def resolve_all(layout)
      @resolved ||= begin
        item = view_lookup(layout, self.target)
        rel_item = view_lookup(layout, self.relative_to)

        [0, 1].map do |index|
          attribute = attribute_lookup(self.attribute[index])

          nsconstraint = NSLayoutConstraint.constraintWithItem(item,
            attribute: attribute,
            relatedBy: relationship_lookup(self.relationship),
            toItem: rel_item,
            attribute: attribute,
            multiplier: self.multiplier[index],
            constant: self.constant[index]
            )

          if @priority
            nsconstraint.priority = priority_lookup(self.priority)
          end

          if @identifier
            nsconstraint.setIdentifier(@identifier)
          end

          nsconstraint
        end
      end
    end

  end

end
