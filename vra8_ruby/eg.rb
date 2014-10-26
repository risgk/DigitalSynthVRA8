require './common'
require './env_table'

class EG
  STATE_ATTACK = 0
  STATE_DECAY = 1
  STATE_SUSTAIN = 2
  STATE_RELEASE = 3
  STATE_IDLE = 4

  def initialize
    @attack_speed = 255
    @decay_speed = 255
    @sustain_level = 127
    @state = STATE_IDLE
    @count = 0
    @level = 0
  end

  def set_attack_time(attack_time)
    @attack_speed = $env_table_speed_from_time[attack_time]
  end

  def set_decay_time(decay_time)
    @decay_speed = $env_table_speed_from_time[decay_time]
  end

  def set_sustain_level(sustain_level)
    @sustain_level = sustain_level
  end

  def note_on
    if (@level == 127)
      @state = STATE_DECAY
      @count = 0
    else
      @state = STATE_ATTACK
      @count = $env_table_attack_inverse[@level] << 8
    end
  end

  def note_off
    case (@state)
    when STATE_ATTACK, STATE_DECAY, STATE_SUSTAIN
      @state = STATE_RELEASE
      @count = $env_table_decay_inverse[@level] << 8
    end
  end

  def sound_off
    @state = STATE_IDLE
    @count = 0
    @level = 0
  end

  def clock
    case (@state)
    when STATE_ATTACK
      @count += @attack_speed
      @level = $env_table_attack[high_byte(@count)]
      if (high_byte(@count) == 255)
        @state = STATE_DECAY
        @count = 0
      end
    when STATE_DECAY
      @count += @decay_speed
      @level = $env_table_decay[high_byte(@count)]
      @level = high_byte(@level * ((127 - @sustain_level) << 1))
      @level += @sustain_level
      if (high_byte(@count) == 255)
        @state = STATE_SUSTAIN
      end
    when STATE_SUSTAIN
      @level = @sustain_level
    when STATE_RELEASE
      @count += @decay_speed
      @level = $env_table_decay[high_byte(@count)]
      if (high_byte(@count) == 255)
        @state = STATE_IDLE
      end
    when STATE_IDLE
      @level = 0
    end

    return @level
  end
end
