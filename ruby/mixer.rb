require './common'

class Mixer
  def clock(a, b, c, d)
    return (a + b + c + d) >> 2
  end
end
