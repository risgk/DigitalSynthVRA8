require './common'
require './filter_table'
require './env_table'

class Filter
  def initialize
    @cutoff_freq = 127
    @resonance = false
    @envelope_switch = false
    @x0 = 0
    @x1 = 0
    @x2 = 0
    @y0 = 0
    @y1 = 0
    @y2 = 0
  end

  def set_cutoff_freq(cutoff_freq)
    @cutoff_freq = cutoff_freq
  end

  def set_resonance(resonance)
    @resonance = resonance
  end

  def set_envelope_switch(envelope_switch)
    @envelope_switch = envelope_switch
  end

  def clock(a, k)
    i0 = @resonance ? 1 : 0
    i1 = @envelope_switch ? ((@cutoff_freq + k) / 2) : @cutoff_freq
    coef = $filter_tables[i0][i1]
    b1_a0 = coef[0]
    b2_a0 = coef[1]
    a1_a0 = coef[2]
    a2_a0 = coef[3]

    @x0 = a
    @y0 = high_byte(((b2_a0 * @x0) + (b1_a0 * @x1) + (b2_a0 * @x2) + (a1_a0 * @y1) - (a2_a0 * @y2)) << 2)
    @x2 = @x1
    @x1 = @x0
    @y2 = @y1
    @y1 = @y0
    return @y0
  end
end
