require './common'
require './program_table'
require './osc'
require './mixer'
require './eg'
require './filter'
require './amp'

$osc_1 = Osc.new
$osc_2 = Osc.new
$osc_3 = Osc.new
$mixer = Mixer.new
$eg = EG.new
$filter = Filter.new
$amp = Amp.new

class Synth
  def initialize
    @running_status = MIDI_ACTIVE_SENSING
    @midi_in_prev = MIDI_ACTIVE_SENSING
    @midi_in_pprev = MIDI_ACTIVE_SENSING
    @note_number = 60
    program_change(0)
  end

  def receive_midi_byte(b)
    # todo: running status, control change, program change, system messages
    if (@midi_in_pprev == MIDI_NOTE_ON && @midi_in_prev <= MIDI_DATA_BYTE_MAX &&
        b <= MIDI_DATA_BYTE_MAX && b >= 0x01)
      note_number = @midi_in_prev
      note_on(note_number)
      @note_number = note_number
    end
    if ((@midi_in_pprev == MIDI_NOTE_ON  && @midi_in_prev <= MIDI_DATA_BYTE_MAX && b == 0x00) ||
        (@midi_in_pprev == MIDI_NOTE_OFF && @midi_in_prev <= MIDI_DATA_BYTE_MAX && b <= MIDI_DATA_BYTE_MAX))
      note_number = @midi_in_prev
      if @note_number == note_number
        note_off(note_number)
      end
    end
    @midi_in_pprev = @midi_in_prev
    @midi_in_prev = b
  end

  def clock
    level = $mixer.clock($osc_1.clock, $osc_2.clock, $osc_3.clock)
    eg_output = $eg.clock
    level = $filter.clock(level, eg_output)
    level = $amp.clock(level, eg_output)
  end

  private
  def system_message?(b)
    b >= MIDI_SYSTEM_MESSAGES_MIN
  end

  def data_byte?(b)
    b <= MIDI_DATA_BYTE_MAX
  end

  def note_on(note_number)
    $osc_1.note_on(note_number)
    $osc_2.note_on(note_number)
    $osc_3.note_on(note_number)
    $eg.note_on(note_number)
  end

  def note_off(note_number)
    $osc_1.note_off(note_number)
    $osc_2.note_off(note_number)
    $osc_3.note_off(note_number)
    $eg.note_off(note_number)
  end

  def control_change(controller_number, value)
    # todo
  end

  def program_change(program_number)
    @program_number = program_number

    i = @program_number * 14
    $osc_1.set_waveform($program_table[i])
    i += 1
    $osc_2.set_waveform($program_table[i])
    i += 1
    $osc_2.set_coarse_tune($program_table[i])
    i += 1
    $osc_2.set_fine_tune($program_table[i])
    i += 1
    $osc_3.set_waveform($program_table[i])
    i += 1
    $osc_3.set_coarse_tune($program_table[i])
    i += 1
    $osc_3.set_fine_tune($program_table[i])
    i += 1
    $eg.set_attack($program_table[i])
    i += 1
    $eg.set_decay($program_table[i])
    i += 1
    $eg.set_sustain($program_table[i])
    i += 1
    $eg.set_release($program_table[i])
    i += 1
    $filter.set_cutoff($program_table[i])
    i += 1
    $filter.set_resonance($program_table[i])
    i += 1
    $filter.set_envelope($program_table[i])
  end
end
