require_relative 'WifiBridgeBase.rb'
require 'socket'

class WifiBridge < WifiBridgeBase
  def initialize(host, port=8899) super()

    @host = host
    @port = port
    @conn = UDPSocket.new
  end

protected
  def send(mesg)
    @conn.send(mesg, 0, @host, @port)
  end
end