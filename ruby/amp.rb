require './common'
require './env_table'

class Amp
  def clock(a, k)
    high_byte(a * (k << 1))
  end
end
