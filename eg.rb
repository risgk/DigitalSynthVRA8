require './common'

class EG
  STATE_A = 0
  STATE_D = 1
  STATE_S = 2
  STATE_R = 3

  def initialize
    @level = 0
    @state = STATE_A
    @rest = 0
    @envelope_table = [10,40,200,20]
  end

  def note_on
    @state = STATE_A
    @level = 0
    @rest = @envelope_table[@state]
  end

  def note_off
    @state = STATE_R
    @rest = @envelope_table[@state]
  end

  def clock
    @rest -= 1
    case (@state)
    when STATE_A
      if (@rest <= 0)
        if (@level < 255)
          @level += 1
          @rest = @envelope_table[@state]
        else
          @state = STATE_D
          @rest = @envelope_table[@state]
        end
      end
    when STATE_D
      if (@rest <= 0)
        if (@level > @envelope_table[2])
          @level -= 1
          @rest = @envelope_table[@state]
        else
          @state = STATE_S
          @rest = 9999
        end
      end
    when STATE_S
      # do nothing
    when STATE_R
      if (@rest <= 0)
        if (@level > 0)
          @level -= 1
          @rest = @envelope_table[@state]
        else
          @level = 0
          @rest = 9999
        end
      end
    end

    return @level
  end
end
