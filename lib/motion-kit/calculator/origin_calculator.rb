# @provides MotionKit::OriginCalculator
module MotionKit

  class OriginCalculator

    attr_reader :x, :y, :x_offset, :y_offset

    def initialize(view, dimension, amount, my_size=nil, full_view)
      @view = view
      @dimension = dimension
      @amount = amount
      @my_size = my_size || view.frame.size
      @full_view = full_view
      @x_offset = 0
      @y_offset = 0
      calculate
    end

    # Methodzilla
    # Refactor ideas welcome.
    def calculate
      if @amount.is_a?(Hash)
        if @amount[:relative]
          @x = @amount[:x] || begin
            x = @view.frame.origin.x
            x += @my_size.width / 2.0 if @dimension == :center
            x
          end

          @y = @amount[:y] || begin
            y = @view.frame.origin.y
            y += @my_size.height / 2.0 if @dimension == :center
            y
          end

          @x_offset = @amount[:right] if @amount.key?(:right)
          @x_offset = -@amount[:left] if @amount.key?(:left)

          @y_offset = @amount[:down] if @amount.key?(:down)
          @y_offset = -@amount[:up] if @amount.key?(:up)
          @y_offset = -@y_offset if @amount[:flipped]
        else
          if @amount.key?(:right)
            @x_offset = -@my_size.width
            @x = @amount[:right]
          elsif @amount.key?(:x) || @amount.key?(:left)
            @x = @amount[:x] || @amount[:left]
          elsif @dimension == :center
            @x = @view.frame.origin.x + (@my_size.width / 2)
          else
            @x = @view.frame.origin.x
          end

          if @amount.key?(:bottom)
            @y_offset = -@my_size.height
            @y = @amount[:bottom]
          elsif @amount.key?(:y) || @amount.key?(:top)
            @y = @amount[:y] || @amount[:top]
          elsif @dimension == :center
            @y = @view.frame.origin.y + (@my_size.height / 2)
          else
            @y = @view.frame.origin.y
          end
        end
      else
        @x = @amount[0]
        @y = @amount[1]
      end
    end

  end

end
