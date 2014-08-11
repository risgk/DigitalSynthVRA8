require './common'

class Amplifier
  def initialize
    @volume = 0x7F
  end

  def set_volume(volume)
    @volume = $rounding_table_128_to_5[volume]
  end

  def clock(a, k)
    if (k == 0x7F)
      level = a
    elsif (k == 0x00)
      level = 0
    else
      level = high_byte(a * (k << 1))
    end

    if (@volume != 0x7F)
      level = level
    elsif (@volume == 0x00)
      level = 0
    else
      level = high_byte(level * (@volume << 1))
    end

    return level
  end
end
