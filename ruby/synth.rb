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
      note_on(@midi_in_prev)
    elsif ((@midi_in_pprev == MIDI_NOTE_ON  && @midi_in_prev <= MIDI_DATA_BYTE_MAX && b == 0x00) ||
        (@midi_in_pprev == MIDI_NOTE_OFF && @midi_in_prev <= MIDI_DATA_BYTE_MAX && b <= MIDI_DATA_BYTE_MAX))
      note_off(@midi_in_prev)
    elsif (@midi_in_prev == MIDI_PROGRAM_CHANGE && b <= MIDI_DATA_BYTE_MAX)
      program_change(b)
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
    @note_number = note_number
    $osc_1.note_on(@note_number)
    $osc_2.note_on(@note_number)
    $osc_3.note_on(@note_number)
    $eg.note_on(@note_number)
  end

  def note_off(note_number)
    if note_number == @note_number
      $eg.note_off(@note_number)
    end
  end

  def sound_off
    $osc_1.sound_off
    $osc_2.sound_off
    $osc_3.sound_off
    $eg.sound_off
  end

  def control_change(controller_number, value)
    # todo
  end

  def control_change(value)
    # todo
  end

  def set_osc1_waveform
    sound_off
    $osc_1.set_waveform(value)
  end

  def set_osc2_waveform
    sound_off
    $osc_2.set_waveform(value)
  end

  def set_osc2_coarse_tune
    sound_off
    $osc_2.set_coarse_tune(value)
  end

  def set_osc2_fine_tune
    sound_off
    $osc_2.set_fine_tune(value)
  end

  def set_osc3_waveform
    sound_off
    $osc_3.set_waveform(value)
  end

  def set_osc3_coarse_tune
    sound_off
    $osc_3.set_coarse_tune(value)
  end

  def set_osc3_fine_tune
    sound_off
    $osc_3.set_fine_tune(value)
  end

  def set_filter_envelope
    $filter.set_envelope(value)
  end

  def set_eg_attack
    sound_off
    $eg.set_attack(value)
  end

  def set_eg_decay
    sound_off
    $eg.set_decay(value)
  end

  def set_eg_sustain
    sound_off
    $eg.set_sustain(value)
  end

  def set_eg_release
    sound_off
    $eg.set_release(value)
  end

  def set_filter_cutoff
    $filter.set_cutoff(value)
  end

  def set_filter_resonance
    $filter.set_resonance(value)
  end

  def program_change(program_number)
    @program_number = program_number
    sound_off
    i = @program_number * 14
    $osc_1.set_waveform($program_table[i + 0])
    $osc_1.set_coarse_tune(64)
    $osc_1.set_fine_tune(64)
    $osc_2.set_waveform($program_table[i + 1])
    $osc_2.set_coarse_tune($program_table[i + 2])
    $osc_2.set_fine_tune($program_table[i + 3])
    $osc_3.set_waveform($program_table[i + 4])
    $osc_3.set_coarse_tune($program_table[i + 5])
    $osc_3.set_fine_tune($program_table[i + 6])
    $eg.set_attack($program_table[i + 7])
    $eg.set_decay($program_table[i + 8])
    $eg.set_sustain($program_table[i + 9])
    $eg.set_release($program_table[i + 10])
    $filter.set_cutoff($program_table[i + 11])
    $filter.set_resonance($program_table[i + 12])
    $filter.set_envelope($program_table[i + 13])
  end
end
