require './common'

class Amplifier
  def initialize
    @volume = 0x7F
  end

  def clock(a, k)
    level = high_byte(a * k) + 0x80 - high_byte(0x80 * k)

    reduction = 0x03 - (@volume >> 5)
    if (reduction == 0x03)
      level = 0x80
    else
      level = (level >> reduction) + 0x80 - (0x80 >> reduction)
    end

    return level
  end
end
