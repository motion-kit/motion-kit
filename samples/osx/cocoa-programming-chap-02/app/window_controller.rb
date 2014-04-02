class WindowController < NSWindowController

  def init
    super.tap do
      @random = Random.new(Time.now.to_i)

      @layout = WindowLayout.new
      self.window = @layout.window

      @seed_button = @layout.get(:seed_button)
      @seed_button.setTarget(self)
      @seed_button.setAction(:'seed:')

      @generate_button = @layout.get(:generate_button)
      @generate_button.setTarget(self)
      @generate_button.setAction(:'generate:')

      @number_field = @layout.get(:number_field)
    end
  end

  def seed(sender)
    seed = Time.now.to_i
    @random = Random.new(seed)
    @number_field.stringValue = "Generator seeded with #{seed}"
  end

  def generate(sender)
    generated = @random.rand(100)
    @number_field.setIntValue(generated)
  end

end
