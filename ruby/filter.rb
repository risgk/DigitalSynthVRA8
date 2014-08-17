require './common'
require './filter_table'

class Filter
  def initialize
    @cutoff = 127
    @resonance = 0
    @envelope = 0
    @x0 = 0
    @x1 = 0
    @x2 = 0
    @y0 = 0
    @y1 = 0
    @y2 = 0
  end

  def set_cutoff(cutoff)
    @cutoff = cutoff
  end

  def set_resonance(resonance)
    @resonance = resonance
  end

  def set_envelope(envelope)
    @envelope = envelope
  end

  def clock(a, k)
    reso = ((@resonance & 0x40) != 0) ? 1 : 0
    freq = ((@envelope & 0x40) != 0) ? ((@cutoff + k) / 2) : @cutoff
    coef = $filter_tables[reso][freq]
    b1a0 = coef[0]
    b2a0 = coef[1]
    a1a0 = coef[2]
    a2a0 = coef[3]

    @x0 = a
    @y0 = high_byte(((b2a0 * @x0) + (b1a0 * @x1) + (b2a0 * @x2) + (a1a0 * @y1) - (a2a0 * @y2)) << 2)
    @x2 = @x1
    @x1 = @x0
    @y2 = @y1
    @y1 = @y0

    return @y0
  end
end
