require './common'

class Mixer
  def clock(a, b, c, d)
    level_10 = a + b + c + d
    level = ((high_byte(level_10) << 6) & 0xFF) + ((low_byte(level_10) >> 2) & 0xFF)
    return level
  end
end
