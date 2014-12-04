require_relative 'lib/FakeWifiBridge.rb'
require_relative 'lib/WifiBridge.rb'
 
conn = WifiBridge.new("192.168.1.79")

=begin
conn.group(0).white
conn.group(1).white
conn.group(2).white
conn.group(3).white

sleep(1)

conn.group(0).off
conn.group(1).off
conn.group(2).off
conn.group(3).off
=end

(0..360).step(2) do |i|
  conn.group(0).hue = i
  sleep(0.1)
end

conn.blockForCompletion
