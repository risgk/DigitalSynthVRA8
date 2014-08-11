require './common'

class Filter
  def initialize
    @x_0, @x_1, @x_2 = 0, 0, 0
    @y_0, @y_1, @y_2 = 0, 0, 0
    @b1_a0, @b2_a0, @a1_a0, @a2_a0 = 37, 19,   0, 11 # cutoff = AUDIO_RATE /  4, Q = 0.7071
#   @b1_a0, @b2_a0, @a1_a0, @a2_a0 = 12,  6, -60, 21 # cutoff = AUDIO_RATE /  8, Q = 0.7071
#   @b1_a0, @b2_a0, @a1_a0, @a2_a0 =  4,  2, -93, 37 # cutoff = AUDIO_RATE / 16, Q = 0.7071
  end

  def clock(a, k)
    @x_0 = a
    @y_0 = ((@b2_a0 * @x_0) + (@b1_a0 * @x_1) + (@b2_a0 * @x_2) - (@a1_a0 * @y_1) - (@a2_a0 * @y_2)) / 64;
    @x_2 = @x_1;
    @x_1 = @x_0;
    @y_2 = @y_1;
    @y_1 = @y_0;
    return @y_0
  end
end
