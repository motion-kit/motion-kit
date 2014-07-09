# @provides MotionKit::BaseLayoutClassMethods
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

      if BaseLayout.target_klasses.key?(klass) && BaseLayout.target_klasses[klass] != self
        NSLog('WARNING!  The class “%@” was registered with the layout class “%@”',
          klass, BaseLayout.target_klasses[klass])
      end
      BaseLayout.target_klasses[klass] = self

      nil
    end

    # Instantiates a new Layout instance using `layout` as the root-level layout
    def layout_for(klass)
      memoized_klass = memoize(klass)
      memoized_klass && memoized_klass.new
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

  end
end
