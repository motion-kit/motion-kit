# @provides MotionKit::Calculator
module MotionKit
  class Calculator
    attr_accessor :factor, :constant

    def self.memo
      @memo ||= {}
    end

    def self.scan(amount)
      amount = amount.gsub(' ', '')
      Calculator.memo[amount] ||= Calculator.new(amount)
    end

    def initialize(amount)
      location = amount.index '%'
      if location
        self.factor = amount.slice(0, location).to_f / 100.0
        location += 1
      else
        self.factor = 0
        location = 0
      end
      self.constant = amount.slice(location, amount.size).to_f
    end

  end
end
