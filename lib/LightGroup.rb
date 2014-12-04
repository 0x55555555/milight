require_relative 'GroupBase.rb'

class LightGroup
  def initialize(on, off, white, controller)
    @on = on
    @off = off
    @white = white
    @controller = controller
  end

include GroupBase
  def off
    @controller.command(@off)
  end

  def on
    @controller.command(@on)
  end

  def white
    @controller.command(@on)
    @controller.hold()
    @controller.command(@white)
  end

  def setBrightness(val)
    raise "Invalid brightness" unless val >= 0.0 && val <= 1.0

    brightness = val * 25

    @controller.command(@on)  
    @controller.hold()
    @controller.command(0x4E, (0x2 + brightness).round)
  end

  def setHue(hue)
    raise "Invalid hue" unless hue >= 0.0 && hue <= 360.0

    val = (360 - hue) - 120
    val = val % 360.0

    val = (val/360.0) * 0xFF

    @controller.command(@on)  
    @controller.hold()
    @controller.command(0x40, val.round)
  end

end