class ChatRoom
  attr_accessor :name

  def initialize(firebase=nil)
    if firebase
      @name = firebase['name']
    end
  end

end
