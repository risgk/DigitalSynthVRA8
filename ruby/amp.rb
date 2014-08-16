require './common'

class Amp
  def clock(a, k)
    high_byte(a * (k << 1))
  end
end
