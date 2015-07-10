# @provides MotionKit::Constraint
# @provides MotionKit::CompoundConstraint
module MotionKit
  class InvalidRelationshipError < Exception
  end
  class InvalidAttributeError < Exception
  end
  class InvalidPriorityError < Exception
  end

  class Constraint
    attr_accessor :target
    attr_accessor :attribute
    attr_accessor :relationship
    attr_accessor :relative_to
    attr_accessor :attribute2
    attr_reader :multiplier
    attr_reader :constant
    attr_writer :priority
    attr_writer :identifier

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

    def initialize(target, attribute=nil, relationship)
      @target = target
      @attribute = attribute
      @attribute2 = attribute
      @relative_to = nil
      @relationship = relationship
      @multiplier = 1
      @constant = 0
      @priority = nil
      @compare_flag = false
      @active = true
    end

    # like `equals`, but also sets `compare_flag` to true, so you can use ==,
    # <=, and >=
    #
    # @example
    #     x.is(10)
    #     x.is(10).priority(:required)
    #     x.is == 10
    #     (x.is == 10).priority :required
    #     width.is >= 100
    #     height.is <= 200
    def is(value=nil)
      if value
        self.equals(value)
      end
      @compare_flag = true
      self
    end

    def ==(compare)
      if @compare_flag
        equals(compare)

        self
      else
        super
      end
    end

    def >=(compare)
      if @compare_flag
        gte(compare)

        self
      else
        super
      end
    end

    def <=(compare)
      if @compare_flag
        lte(compare)

        self
      else
        super
      end
    end

    def equals(target, attribute2=nil)
      self.relationship ||= :equal
      if Constraint.constant?(target)
        self.constant = target
      elsif Constraint.calculate?(target)
        calc = Calculator.scan(target)
        self.multiplier = calc.factor
        self.constant = calc.constant || 0
      else
        self.relative_to = target
        if attribute2
          self.attribute2 = attribute2
        end
      end
      @compare_flag = false
      self
    end
    alias is_equal_to equals
    alias equal_to equals

    def lte(target, attribute2=nil)
      self.relationship = :lte
      if Constraint.constant?(target)
        self.constant = target
      elsif Constraint.calculate?(target)
        calc = Calculator.scan(target)
        self.multiplier = calc.factor
        self.constant = calc.constant || 0
      else
        self.relative_to = target
        if attribute2
          self.attribute2 = attribute2
        end
      end
      @compare_flag = false
      self
    end
    alias is_at_most lte
    alias at_most lte

    def gte(target, attribute2=nil)
      self.relationship = :gte
      if Constraint.constant?(target)
        self.constant = target
      elsif Constraint.calculate?(target)
        calc = Calculator.scan(target)
        self.multiplier = calc.factor
        self.constant = calc.constant || 0
      else
        self.relative_to = target
        if attribute2
          self.attribute2 = attribute2
        end
      end
      @compare_flag = false
      self
    end
    alias is_at_least gte
    alias at_least gte

    # width.is('100%').of(:view, :width)
    def of(target, attribute2=nil)
      self.relative_to = target
      if attribute2
        self.attribute2 = attribute2
      end
      self
    end

    def constant=(constant)
      @constant = constant

      case Constraint.attribute_lookup(self.attribute)
      when NSLayoutAttributeLeft, NSLayoutAttributeRight, NSLayoutAttributeTop, NSLayoutAttributeBottom, NSLayoutAttributeLeading, NSLayoutAttributeTrailing, NSLayoutAttributeCenterX, NSLayoutAttributeCenterY, NSLayoutAttributeBaseline
        self.relative_to ||= :superview
      end

      self.update_constraint
    end

    def multiplier=(multiplier)
      @multiplier = multiplier
      self.update_constraint
    end

    def times(multiplier)
      self.multiplier *= multiplier
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
      unless self.relationship
        constant = -constant
      end
      self.constant += constant
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
    alias identified_by identifier

    def update_constraint
      if @resolved
        constraint = @resolved[0]

        constraint.constant = self.constant
      end
    end

    def resolve_all(layout, view)
      @resolved ||= begin
        item = Constraint.view_lookup(layout, view, self.target)
        rel_item = Constraint.view_lookup(layout, view, self.relative_to)
        relationship = Constraint.relationship_lookup(self.relationship)
        attribute1 = Constraint.attribute_lookup(self.attribute)
        attribute2 = Constraint.attribute_lookup(self.attribute2)

        nsconstraint = NSLayoutConstraint.constraintWithItem(item,
          attribute: attribute1,
          relatedBy: relationship,
          toItem: rel_item,
          attribute: attribute2,
          multiplier: self.multiplier,
          constant: self.constant
          )

        if self.priority
          nsconstraint.priority = Constraint.priority_lookup(self.priority)
        end

        if self.identifier
          nsconstraint.setIdentifier(self.identifier)
        end

        [nsconstraint]
      end
    end

    def active
      @active
    end

    def active=(active)
      if @resolved
        if active
          common_ancestor.addConstraint(@resolved[0])
        else
          common_ancestor.removeConstraint(@resolved[0])
        end
      else
        @active = active
      end
    end

    def activate
      self.active = true
      self
    end

    def deactivate
      self.active = false
      self
    end

    def common_ancestor
      if @resolved
        @common_ancestor ||= begin
          constraint = @resolved[0]
          base_view_class = MotionKit.base_view_class

          if constraint.firstItem.is_a?(base_view_class) && constraint.secondItem.is_a?(base_view_class)
            common_ancestor = nil

            ancestors = [constraint.firstItem]
            parent_view = constraint.firstItem
            while parent_view = parent_view.superview
              ancestors << parent_view
            end

            current_view = constraint.secondItem
            while current_view
              if ancestors.include? current_view
                common_ancestor = current_view
                break
              end
              current_view = current_view.superview
            end

            unless common_ancestor
              raise NoCommonAncestorError.new("No common ancestors between #{constraint.firstItem} and #{constraint.secondItem}")
            end
          else
            common_ancestor = constraint.firstItem
          end

          common_ancestor
        end
      end
    end

    class << self

      def axis_lookup(axis)
        case axis
        when :horizontal
          UILayoutConstraintAxisHorizontal
        when :vertical
          UILayoutConstraintAxisVertical
        else
          axis
        end
      end

      def orientation_lookup(orientation)
        case orientation
        when :horizontal
          NSLayoutConstraintOrientationHorizontal
        when :vertical
          NSLayoutConstraintOrientationVertical
        else
          orientation
        end
      end

      def view_lookup(layout, view, target)
        if ! target || target.is_a?(MotionKit.base_view_class)
          target
        elsif target == :self
          view
        elsif target == :superview
          view.superview
        else
          layout.get_view(target)
        end
      end

      def attribute_lookup(attribute)
        if attribute.is_a? Fixnum
          return attribute
        end

        unless Attributes.key? attribute
          raise InvalidAttributeError.new("Unsupported attribute #{attribute.inspect}")
        end

        Attributes[attribute]
      end

      def priority_lookup(priority)
        if priority.is_a? Fixnum
          return priority
        end

        unless Priorities.key? priority
          raise InvalidPriorityError.new("Unsupported priority #{priority.inspect}")
        end

        Priorities[priority]
      end

      def relationship_lookup(relationship)
        if relationship.is_a? Fixnum
          return relationship
        end

        unless Relationships.key? relationship
          raise InvalidRelationshipError.new("Unsupported relationship #{relationship.inspect}")
        end

        Relationships[relationship]
      end

      def attribute_reverse(attribute)
        Attributes.key(attribute) || :none
      end

      def relationship_reverse(relationship)
        Relationships.key(relationship)
      end

      def calculate?(value)
        value.is_a?(String)
      end

      def constant?(value)
        value.is_a?(Numeric) || value.is_a?(Hash) || value.is_a?(Array)
      end

    end

  end

  class CompoundConstraint < Constraint

    def initialize(target, attribute=nil, relationship=:equal)
      super
      @constant = [0, 0]
      @multiplier = [1, 1]
    end

    def update_constraint
      if @resolved
        [0, 1].each do |index|
          constraint = @resolved[index]
          constraint.constant = self.constant[index]
        end
      end
    end

  end

end
