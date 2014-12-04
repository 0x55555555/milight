require_relative 'WifiBridgeBase.rb'

class FakeWifiBridge < WifiBridgeBase
  def initialize(host, port=8899) super()

    @host = host
    @port = port
  end

protected
  def send(mesg)
    str = []
    mesg.each_char { |c| str << "0x#{c.ord.to_s(16)}" }
    puts "#{@host}:#{@port} => [ #{str.join(", ")} ]"
  end
end