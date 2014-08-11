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
    @state = STATE_IDLE
    @count = 0
    @level = 0
    @note_off_level = 0
  end

  def set_adsr(a, d, s, r)
    @as = $env_table_speed_from_time[a]
    @ds = $env_table_speed_from_time[d]
    @sl = $rounding_table_128_to_5[s]
    @rs = $env_table_speed_from_time[s]
  end

  def note_on
    @state = STATE_A
    @count = 0
    @level = 0
    @note_off_level = 0
  end

  def note_off
    case (@state)
    when STATE_A, STATE_D, STATE_S
      @state = STATE_R
      @count = 0
      @note_off_level = @level
    end
  end

  def clock
    case (@state)
    when STATE_A
      @count += @as
      if (@count < 0x8000)
        @level = $env_table_attack[high_byte(@count)]
      else
        @state = STATE_D
        @count = 0
        @level = 127
      end
    when STATE_D
      @count += @ds
      if (@count < 0x8000)
        @level = high_byte($env_table_decay_release[high_byte(@count)] * (127 - @sl)) + @sl
      else
        @state = STATE_S
        @count = 0
        @level = @sl
      end
    when STATE_S
      @level = @sl
    when STATE_R
      @count += @rs
      if (@count < 0x8000)
        @level = $env_table_decay_release[high_byte(@count)]
        @level = 0
      else
        @state = STATE_IDLE
        @count = 0
        @level = 0
      end
    when STATE_IDLE
      @level = 0
    end

    return @level
  end
end
