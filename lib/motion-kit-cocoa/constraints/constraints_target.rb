module MotionKit
  class ConstraintsTarget
    attr :view

    def initialize(target)
      @view = target
      @constraints = []
    end

    def add_constraints(constraints)
      @constraints.concat(constraints)
    end

    def resolve_all(layout)
      @constraints.each do |constraint|
        resolved = constraint.resolve_all(layout)
      end
    end

  end

end
