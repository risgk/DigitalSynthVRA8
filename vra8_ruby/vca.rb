require './common'

class VCA
  def clock(a, k)
    high_byte(a * (k << 1))
  end
end
