require './common'
require './env_table'

class EG
  STATE_ATTACK = 0
  STATE_DECAY = 1
  STATE_SUSTAIN = 2
  STATE_RELEASE = 3
  STATE_IDLE = 4

  def initialize
    @attack_speed = 16
    @decay_plus_release_speed = 16
    @sustain_level = 127
    @state = STATE_IDLE
    @count = 0
    @level = 0
  end

  def set_attack(attack_time)
    @attack_speed = $env_table_speed_from_time[attack_time]
  end

  def set_decay_plus_release(decay_plus_release_time)
    @decay_plus_release_speed = $env_table_speed_from_time[decay_plus_release_time]
  end

  def set_sustain(sustain_level)
    @sustain_level = sustain_level
  end

  def note_on(note_number)
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
      @count = $env_table_decay_plus_release_inverse[@level] << 8
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
      if (high_byte(@count) < 255)
        @level = $env_table_attack[high_byte(@count)]
      else
        @state = STATE_DECAY
        @count = 0
        @level = 127
      end
    when STATE_DECAY
      @count += @decay_plus_release_speed
      @level = $env_table_decay_plus_release[high_byte(@count)]
      if (@level <= @sustain_level)
        @state = STATE_SUSTAIN
        @level = @sustain_level
      end
    when STATE_SUSTAIN
      @level = @sustain_level
    when STATE_RELEASE
      @count += @decay_plus_release_speed
      if (high_byte(@count) < 255)
        @level = $env_table_decay_plus_release[high_byte(@count)]
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
