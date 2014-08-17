require './common'
require './env_table'

class EG
  STATE_ATTACK = 0
  STATE_DECAY = 1
  STATE_SUSTAIN = 2
  STATE_RELEASE = 3
  STATE_IDLE = 4

  def initialize
    @attack_speed = $env_table_speed_from_time[0]
    @decay_speed = $env_table_speed_from_time[0]
    @sustain_level = 127
    @release_speed = $env_table_speed_from_time[0]
    @state = STATE_IDLE
    @count = 0
    @level = 0
    @note_off_level = 0
  end

  def set_attack(attack_time)
    @attack_speed = $env_table_speed_from_time[attack_time]
  end

  def set_decay(decay_time)
    @decay_speed = $env_table_speed_from_time[decay_time]
  end

  def set_sustain(sustain_level)
    @sustain_level = sustain_level
  end

  def set_release(release_time)
    @release_speed = $env_table_speed_from_time[release_time]
  end

  def note_on(note_number)
    if (@level == 127)
      @state = STATE_DECAY
      @count = 0
    else
      @state = STATE_ATTACK
      @count = $env_table_attack_count_from_level[@level] << 8
    end
  end

  def note_off(note_number)
    case (@state)
    when STATE_ATTACK, STATE_DECAY, STATE_SUSTAIN
      @state = STATE_RELEASE
      @count = 0
      @note_off_level = @level
    end
  end

  def clock
    case (@state)
    when STATE_ATTACK
      @count += @attack_speed
      if (high_byte(@count) < 255)
        @level = high_byte($env_table_attack[high_byte(@count)] * 127)
      else
        @state = STATE_DECAY
        @count = 0
        @level = 127
      end
    when STATE_DECAY
      @count += @decay_speed
      if (high_byte(@count) < 255)
        @level = high_byte($env_table_decay_release[high_byte(@count)] * (127 - @sustain_level)) +
                 @sustain_level
      else
        @state = STATE_SUSTAIN
        @count = 0
        @level = @sustain_level
      end
    when STATE_SUSTAIN
      @level = @sustain_level
    when STATE_RELEASE
      @count += @release_speed
      if (high_byte(@count) < 255)
        @level = high_byte($env_table_decay_release[high_byte(@count)] * @note_off_level)
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
