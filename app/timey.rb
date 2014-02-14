class Timey

  class << self

    def shared
      @shared ||= self.new('shared')
    end

    def reset
      shared.reset
    end

    def log(info=nil)
      shared.log(info)
    end

    def time(info=nil, &block)
      timer = Timey.new(info)
      block.call
      timer.log
      return timer
    end

  end

  def initialize(name=nil)
    @name = name || 'info'
    reset
  end

  def reset
    @zero = @prev = NSDate.new.to_f
  end

  def log(info=nil)
    now = NSDate.new.to_f
    log = "zero: %@    prev: %@"
    if info
      log << "    %@: %@"
    end
    NSLog(log, (now - @zero).round(3), (now - @prev).round(3), @name, info)
    @prev = now
  end

end
