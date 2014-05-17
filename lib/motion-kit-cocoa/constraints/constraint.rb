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
    end

    # like `equals`, but also sets `compare_flag` to true, so you can use ==,
    # <=, and >=
    #
    # @example
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
        @compare_flag = false

        self
      else
        super
      end
    end

    def >=(compare)
      if @compare_flag
        if @relationship && Constraint.relationship_lookup(@relationship) != NSLayoutRelationEqual
          raise InvalidRelationshipError.new("You cannot use `.is >=` on a constraint that is already defined as #{@relationship}")
        end

        gte(compare)
        @compare_flag = false

        self
      else
        super
      end
    end

    def <=(compare)
      if @compare_flag
        if @relationship && Constraint.relationship_lookup(@relationship) != NSLayoutRelationEqual
          raise InvalidRelationshipError.new("You cannot use `.is <=` on a constraint that is already defined as #{@relationship}")
        end

        lte(compare)
        @compare_flag = false

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
    alias id identifier

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

        nsconstraint = NSLayoutConstraint.constraintWithItem(item,
          attribute: Constraint.attribute_lookup(self.attribute),
          relatedBy: Constraint.relationship_lookup(self.relationship),
          toItem: rel_item,
          attribute: Constraint.attribute_lookup(self.attribute2),
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

    class << self

      def axis_lookup(axis)
        case axis
        when :horizontal
          axis = UILayoutConstraintAxisHorizontal
        when :vertical
          axis = UILayoutConstraintAxisVertical
        end

        return axis
      end

      def orientation_lookup(orientation)
        case orientation
        when :horizontal
          orientation = NSLayoutConstraintOrientationHorizontal
        when :vertical
          orientation = NSLayoutConstraintOrientationVertical
        end

        return orientation
      end

      def view_lookup(layout, view, target)
        if ! target || target.is_a?(MotionKit.base_view_class)
          target
        elsif target.is_a?(ConstraintPlaceholder)
          target.resolve(layout)
        elsif target == :superview
          view.superview
        else
          layout.get(target)
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

        [[:width, 0], [:height, 1]].map do |attribute, index|
          nsconstraint = NSLayoutConstraint.constraintWithItem(item,
            attribute: Constraint.attribute_lookup(attribute),
            relatedBy: Constraint.relationship_lookup(self.relationship),
            toItem: rel_item,
            attribute: Constraint.attribute_lookup(attribute),
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
        @resolved.each do
        end
      end
    end

    def resolve_all(layout, view)
      @resolved ||= begin
        item = Constraint.view_lookup(layout, view, self.target)
        rel_item = Constraint.view_lookup(layout, view, self.relative_to)

        [0, 1].map do |index|
          attribute = Constraint.attribute_lookup(self.attribute[index])

          nsconstraint = NSLayoutConstraint.constraintWithItem(item,
            attribute: attribute,
            relatedBy: Constraint.relationship_lookup(self.relationship),
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
