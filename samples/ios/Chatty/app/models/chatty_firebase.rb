class Chatty
  DEFAULT_ROOM = 'main'
  URL = 'https://motion-firebase.firebaseio.com/'

  class << self

    def ref
      @ref ||= Firebase.new(URL)
    end

    def rooms_ref
      ref['rooms']
    end

    def chat_ref
      ref['chat']
    end

  end


end
