
module GroupBase
  def state=(val)
    if (val == :on)
      on()
    elsif (val == :off)
      off()
    end
  end

  def brightness=(val)
    setBrightness(val)
  end

  def hue=(val)
    setHue(val)
  end
end