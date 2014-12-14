require './common'
require './env_table'

class EG
  STATE_ATTACK        = 0
  STATE_DECAY_SUSTAIN = 1
  STATE_RELEASE       = 3
  STATE_IDLE          = 4
  LEVEL16_127         = 32512
  LEVEL16_190_5       = 48768

  def initialize
    @attack_rate      = $env_table_attack_rate_from_time[0]
    @decay_rate       = $env_table_decay_rate_from_time[0]
    @sustain_level_16 = 127
    @state            = STATE_IDLE
    @level_16         = 0
    @count            = 0
  end

  def set_attack_time(attack_time)
    @attack_rate = $env_table_attack_rate_from_time[attack_time]
  end

  def set_decay_time(decay_time)
    @decay_rate = $env_table_decay_rate_from_time[decay_time]
  end

  def set_sustain_level(sustain_level)
    @sustain_level_16 = sustain_level << 8
  end

  def note_on
    @state = STATE_ATTACK
  end

  def note_off
    @state = STATE_RELEASE
  end

  def sound_off
    @state = STATE_IDLE
    @level_16 = 0
  end

  def clock
    @count += 1
    if (@count < EG_UPDATE_INTERVAL)
      return high_byte(@level_16)
    end
    @count = 0

    case (@state)
    when STATE_ATTACK
      @level_16 = LEVEL16_190_5 - (((LEVEL16_190_5 - @level_16) * @attack_rate) >> 16)
      if (@level_16 >= LEVEL16_127)
        @state = STATE_DECAY_SUSTAIN
        @level_16 = LEVEL16_127
      end
    when STATE_DECAY_SUSTAIN
      if (@level_16 > @sustain_level_16)
        if (@level_16 <= (32 + @sustain_level_16))
          @level_16 = @sustain_level_16
        elsif
          @level_16 = @sustain_level_16 + (((@level_16 - @sustain_level_16) * @decay_rate) >> 16)
        end
      end
    when STATE_RELEASE
      @level_16 = ((@level_16 * @decay_rate) >> 16)
      if (@level_16 <= 32)
        @state = STATE_IDLE
        @level_16 = 0
      end
    when STATE_IDLE
      @level_16 = 0
    end

    return high_byte(@level_16)
  end
end
