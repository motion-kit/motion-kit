class WindowController < NSWindowController

  def init
    super.tap do
      @speech = NSSpeechSynthesizer.alloc.initWithVoice(nil)
      @speech.delegate = self

      @layout = WindowLayout.new
      self.window = @layout.window

      @start_button = @layout.get(:start_button)
      @start_button.setTarget(self)
      @start_button.setAction(:'start:')

      @stop_button = @layout.get(:stop_button)
      @stop_button.setTarget(self)
      @stop_button.setAction(:'stop:')
      @stop_button.enabled = false

      @text_field = @layout.get(:text_field)
    end
  end

  def start(sender)
    say_what = @text_field.stringValue
    if say_what.nil? || say_what.length == 0
      say_what = ([1, 0] * 100).map(&:to_s).shuffle.join('')
    end

    @speech.startSpeakingString(say_what)
    @start_button.enabled = false
    @stop_button.enabled = true
  end

  def stop(sender)
    @speech.stopSpeaking
  end

  def speechSynthesizer(speech, didFinishSpeaking: finished)
    @stop_button.enabled = false
    @start_button.enabled = true
  end

end
