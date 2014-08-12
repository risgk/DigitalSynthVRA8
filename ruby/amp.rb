require './common'
require './env_table'

class Amp
  def clock(a, k)
    if (k == 127)
      level = a
    elsif (k == 0)
      level = 0
    else
      level = high_byte(a * (k << 1))
    end

    return level
  end
end
