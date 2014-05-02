module MotionKit
  class ConstraintPlaceholder

    def initialize(type, name, value=nil)
      @type = type
      @name = name
      @value = value
    end

    def resolve(layout)
      case @type
      when :first
        layout.get(@name)
      when :last
        layout.last(@name)
      when :nth
        layout.nth(@name, @value)
      end
    end

  end
end
