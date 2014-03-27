module MotionKit
  module BaseLayoutClassMethods
    def target_klasses
      # We don't want subclasses, just BaseLayout
      return BaseLayout.target_klasses unless self == BaseLayout
      @target_klasses ||= {}
    end

    def targets(klass=nil)
      return nil if klass.nil? && self == BaseLayout
      return @targets || superclass.targets if klass.nil?
      @targets = klass
      BaseLayout.target_klasses[klass] = self
      nil
    end

    # Instantiates a new Layout instance using `layout` as the root-level layout
    def layout_for(layout, klass)
      memoized_klass = memoize(klass)
      memoized_klass.new_child(layout) if memoized_klass
    end

    # Cache registered classes
    def memoize(klass)
      @memoize ||= {}
      @memoize[klass] ||= begin
        while klass
          break if registered_class = target_klasses[klass]
          klass = klass.superclass
        end
        @memoize[klass] = registered_class if registered_class
      end
      @memoize[klass]
    end

    def new_child(layout=nil)
      child = self.new
      child.set_layout(layout)
      child
    end
  end
end
