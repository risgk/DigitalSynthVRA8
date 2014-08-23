require './common'
require './filter_table'

class VCF
  def initialize
    @cutoff = 127
    @resonance = 0
    @envelope = 0
    @x1 = 0
    @x2 = 0
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
    cutoff = 0
    if ((@envelope & 0x40) != 0)
      cutoff = (@cutoff + k) >> 1
    else
      cutoff = @cutoff
    end

    if ((@resonance & 0x40) != 0)
      i = cutoff * 4
      b1_over_a0 = $filter_table_q_sqrt_2[i + 0]
      b2_over_a0 = $filter_table_q_sqrt_2[i + 1]
      a1_over_a0 = $filter_table_q_sqrt_2[i + 2]
      a2_over_a0 = $filter_table_q_sqrt_2[i + 3]
    else
      i = cutoff * 4
      b1_over_a0 = $filter_table_q_1_over_sqrt_2[i + 0]
      b2_over_a0 = $filter_table_q_1_over_sqrt_2[i + 1]
      a1_over_a0 = $filter_table_q_1_over_sqrt_2[i + 2]
      a2_over_a0 = $filter_table_q_1_over_sqrt_2[i + 3]
    end

    x0 = a
    y0 = high_byte(((b2_over_a0 *  x0) + (b1_over_a0 * @x1) + (b2_over_a0 * @x2) +
                    (a1_over_a0 * @y1) - (a2_over_a0 * @y2)) << 2)
    @x2 = @x1
    @y2 = @y1
    @x1 = x0
    @y1 = y0

    return y0
  end
end
