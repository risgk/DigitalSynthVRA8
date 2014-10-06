require './common'

class VCA
  def clock(a, k)
    high_byte(a * (k * 2))
  end
end
