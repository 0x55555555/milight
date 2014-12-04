require_relative 'LightGroup.rb'

class WifiBridgeBase
  def initialize()
    @delay = 0.2

    @commands = []
    @commandMutex = Mutex.new
    @commandResource = ConditionVariable.new
    @commandExit = false

    @commandThread = Thread.new {
      while true do
        cmd = nil

        @commandMutex.synchronize {
          if (@commandExit == true &&
              @commands.length == 0)
            Thread.exit
          end

          while @commands.length == 0 do
            @commandResource.wait(@commandMutex)
          end

          cmd = @commands.shift
        }

        if (cmd.length == 3)
          send(cmd.pack('C*'))
        else
          raise "Invalid command packet" unless cmd.length == 0
          sleep(@delay)
        end
      end
    }
  end

  def blockForCompletion()
    @commandResource.broadcast

    while true do
      len = 0
      @commandMutex.synchronize {
        len = @commands.length
      }

      if len == 0 then
        break
      end
      sleep(@delay)
    end
  end

  def group(num)
    raise "Group index '#{num}' out of range" unless (num >= 0 && num <= 3)
    offset = num * 2
    return LightGroup.new(
      0x45 + offset,
      0x46 + offset,
      0xC5 + offset,
      self)
  end
  
  def allOff
    @controller.command(0x41)
  end

  def allOn
    @controller.command(0x42)
  end

  def disco
    @controller.command(0x4D)
  end
  
  def discoFaster
    @controller.command(0x43)
  end
  
  def discoSlower
    @controller.command(0x44)
  end

  def command(a, b = 0x00)
    @commandMutex.synchronize {
      @commands << [ a, b, 0x55 ]
      @commandResource.broadcast
    }
  end

  def hold()
    @commandMutex.synchronize {
      @commands << [ ]
      @commandResource.broadcast
    }
  end
end