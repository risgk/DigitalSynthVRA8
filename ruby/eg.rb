require './common'
require './env_table'

class EG
  STATE_A = 0
  STATE_D = 1
  STATE_S = 2
  STATE_R = 3
  STATE_IDLE = 4

  def initialize
    @as = 256
    @ds = 256
    @sl = 127
    @rs = 256
    @count = 0
    @state = STATE_IDLE
    @level = 0
    @note_off_level = 0
  end

  def set_adsr(a, d, s, r)
    @as = $env_table_speed_from_time[a]
    @ds = $env_table_speed_from_time[d]
    @sl = $rounding_table_128_to_5[s]
    @rs = $env_table_speed_from_time[r]
  end

  def note_on
    @count = 0
    @state = STATE_A
    @level = 0
  end

  def note_off
    case (@state)
    when STATE_A, STATE_D, STATE_S
      @count = 0
      @state = STATE_R
      @note_off_level = @level
    end
  end

  def clock
    case (@state)
    when STATE_A
      @count += @as
      if (@count < 0xFF00)
        @level = high_byte($env_table_attack[high_byte(@count)] * 127)
      else
        @count = 0
        @state = STATE_D
        @level = 127
      end
    when STATE_D
      @count += @ds
      if (@count < 0xFF00)
        @level = high_byte($env_table_decay_release[high_byte(@count)] * (127 - @sl)) + @sl
      else
        @count = 0
        @state = STATE_S
        @level = @sl
      end
    when STATE_S
      @level = @sl
    when STATE_R
      @count += @rs
      if (@count < 0xFF00)
        @level = high_byte($env_table_decay_release[high_byte(@count)] * @note_off_level)
      else
        @count = 0
        @state = STATE_IDLE
        @level = 0
      end
    when STATE_IDLE
      @level = 0
    end

    return @level
  end
end
