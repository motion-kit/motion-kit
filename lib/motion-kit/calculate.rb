module MotionKit
  module_function

  def calculate(view, dimension, amount)
    if amount.is_a? Proc
      view.instance_exec(&amount)
    elsif amount == :auto
      size_that_fits = view.sizeThatFits([0, 0])

      return case dimension
      when :width
        size_that_fits.width
      when :height
        size_that_fits.height
      end
    elsif amount.is_a?(String) && amount.include?('%')
      calc = Calculator.scan(amount)

      factor = calc.factor
      constant = calc.constant

      return case dimension
      when :width
        (view.superview.frame.size.width * factor + constant).round
      when :height
        (view.superview.frame.size.height * factor + constant).round
      else
        raise "Unknown dimension #{dimension}"
      end
    else
      amount
    end
  end

  class Calculator
    attr_accessor :factor, :constant

    def self.memo
      @memo ||= {}
    end

    def self.scan(amount)
      amount = amount.gsub(' ', '')
      return Calculator.memo[amount] if Calculator.memo[amount]

      calc = Calculator.new

      location = amount.index '%'
      if location
        calc.factor = amount.slice(0, location).to_f / 100.0
        location += 1
      else
        calc.factor = 0
        location = 0
      end
      calc.constant = amount.slice(location, amount.size).to_f

      Calculator.memo[amount] = calc
      return calc
    end

  end

end
