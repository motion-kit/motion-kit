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
      if target.is_a?(Numeric)
        @constant = target
      else
        @relative_to = target
        if attribute2
          @attribute2 = attribute2
        end
      end
      return self
    end
    alias is_equal_to equals

    def lte(target, attribute2=nil)
      @relationship ||= :lte
      if target.is_a?(Numeric)
        @constant = target
      else
        @relative_to = target
        if attribute2
          @attribute2 = attribute2
        end
      end
      return self
    end
    alias is_at_most lte

    def gte(target, attribute2=nil)
      @relationship ||= :gte
      if target.is_a?(Numeric)
        @constant = target
      else
        @relative_to = target
        if attribute2
          @attribute2 = attribute2
        end
      end
      return self
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

    def nslayoutconstraint
      nsconstraint = NSLayoutConstraint.constraintWithItem( self.target,
                                  attribute: self.attribute,
                                  relatedBy: self.relationship,
                                     toItem: self.relative_to,
                                  attribute: self.attribute2,
                                 multiplier: self.multiplier,
                                   constant: self.constant
                                           )
      nsconstraint.priority = priority_lookup(self.priority)
      nsconstraint.setIdentifier(self.identifier) if self.identifier
      return nsconstraint
    end

    private def attribute_lookup(attribute)
      return attribute if attribute.is_a? Fixnum
      raise "Unsupported attribute #{attribute.inspect}" unless Attributes.key? attribute
      Attributes[attribute]
    end

    private def priority_lookup(priority)
      return priority if priority.is_a? Fixnum
      raise "Unsupported priority #{priority.inspect}" unless Priorities.key? priority
      Priorities[priority]
    end

    private def relationship_lookup(relationship)
      return relationship if relationship.is_a? Fixnum
      raise "Unsupported relationship #{relationship.inspect}" unless Relationships.key? relationship
      Relationships[relationship]
    end

    private def attribute_reverse(attribute)
      Attributes.key(attribute) || :none
    end

    private def relationship_reverse(relationship)
      Relationships.key(relationship)
    end

  end
end
