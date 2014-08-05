require './common'

class Amplifier
  def initialize
    @volume = 0x7F
  end

  def clock(a, k)
    if (k == 0x7F)
      level = a
    else
      level = high_byte(a * (k << 1))
    end

    reduction = 0x03 - (@volume >> 5)
    if (reduction == 0x03)
      level = 0
    else
      level = level >> reduction
    end

    return level
  end
end
