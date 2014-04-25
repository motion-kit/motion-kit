module MotionKit
  class ConstraintsTarget

    def initialize
      @constraints = []
    end

    def add_constraints(constraints)
      @constraints.concat(constraints)
    end

    def resolve_all(root)
    end

  end

end
