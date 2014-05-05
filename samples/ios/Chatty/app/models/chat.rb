class Chat
  attr_accessor :content
  attr_accessor :from
  attr_accessor :created

  def initialize(firebase=nil)
    if firebase
      @content = firebase['content']
      @from = firebase['from']
      @created = firebase['created'].nsdate
    end
  end

end
