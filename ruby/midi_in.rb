require './common'
require './program_table'

class MIDIIn
  def initialize
    @running_status = MIDI_EOX
  end

  def receive_byte(b)
    # todo
  end

  def note_on(note_number)
    # todo
  end

  def note_off
    # todo
  end

  def control_change(controller_number, value)
    # todo
  end

  def program_change(program_number)
    # todo
  end

  def system_message?(b)
    b >= MIDI_SYSTEM_MESSAGES_MIN
  end

  def data_byte?(b)
    b <= MIDI_DATA_BYTE_MAX
  end
end
