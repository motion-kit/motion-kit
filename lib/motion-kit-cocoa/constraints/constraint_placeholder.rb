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
        layout.get_view(@name)
      when :last
        layout.last_view(@name)
      when :nth
        layout.nth_view(@name, @value)
      end
    end

  end
end
