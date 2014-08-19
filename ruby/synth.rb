require './common'
require './program_table'
require './osc'
require './filter'
require './amp'
require './eg'
require './mixer'

$osc_1 = Osc.new
$osc_2 = Osc.new
$osc_3 = Osc.new
$filter = Filter.new
$amp = Amp.new
$eg = EG.new
$mixer = Mixer.new

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
  def real_time_message?(b)
    b >= MIDI_REAL_TIME_MIN
  end

  def system_message?(b)
    b >= MIDI_SYSTEM_MIN
  end

  def data_byte?(b)
    b <= MIDI_DATA_BYTE_MAX
  end

  def note_on(note_number)
    # special: program toggle
    if (note_number == PROGRAM_TOGGLE_NOTE_NUMBER)
      program_number = @program_number + 1
      if (program_number > PC_TRUE_NUMBER_MAX)
        program_number = 0
      end
      program_change(program_number)
      return
    end

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
    case (controller_number)
    when CC_OSC1_WAVEFORM
      set_osc1_waveform(value)
    when CC_OSC2_WAVEFORM
      set_osc2_waveform(value)
    when CC_OSC2_COARSE_TUNE
      set_osc2_coarse_tune(value)
    when CC_OSC2_FINE_TUNE
      set_osc2_fine_tune(value)
    when CC_OSC3_WAVEFORM
      set_osc3_waveform(value)
    when CC_OSC3_COARSE_TUNE
      set_osc3_coarse_tune(value)
    when CC_OSC3_FINE_TUNE
      set_osc3_fine_tune(value)
    when CC_FILTER_CUTOFF
      set_filter_cutoff(value)
    when CC_FILTER_RESONANCE
      set_filter_resonance(value)
    when CC_FILTER_ENVELOPE
      set_filter_envelope(value)
    when CC_EG_ATTACK
      set_eg_attack(value)
    when CC_EG_DECAY_RELEASE
      set_decay_release(value)
    when CC_EG_SUSTAIN
      set_eg_sustain(value)
    end
  end

  def set_osc1_waveform(value)
    sound_off
    $osc_1.set_waveform(value)
  end

  def set_osc2_waveform(value)
    sound_off
    $osc_2.set_waveform(value)
  end

  def set_osc2_coarse_tune(value)
    sound_off
    $osc_2.set_coarse_tune(value)
  end

  def set_osc2_fine_tune(value)
    sound_off
    $osc_2.set_fine_tune(value)
  end

  def set_osc3_waveform(value)
    sound_off
    $osc_3.set_waveform(value)
  end

  def set_osc3_coarse_tune(value)
    sound_off
    $osc_3.set_coarse_tune(value)
  end

  def set_osc3_fine_tune(value)
    sound_off
    $osc_3.set_fine_tune(value)
  end

  def set_filter_cutoff(value)
    $filter.set_cutoff(value)
  end

  def set_filter_resonance(value)
    $filter.set_resonance(value)
  end

  def set_filter_envelope(value)
    $filter.set_envelope(value)
  end

  def set_eg_attack(value)
    sound_off
    $eg.set_attack(value)
  end

  def set_decay_release(value)
    sound_off
    $eg.set_decay_release(value)
  end

  def set_eg_sustain(value)
    sound_off
    $eg.set_sustain(value)
  end

  def program_change(program_number)
    @program_number = program_number
    sound_off
    i = @program_number * 13
    $osc_1.set_waveform($program_table[i + 0])
    $osc_1.set_coarse_tune(64)
    $osc_1.set_fine_tune(64)
    $osc_2.set_waveform($program_table[i + 1])
    $osc_2.set_coarse_tune($program_table[i + 2])
    $osc_2.set_fine_tune($program_table[i + 3])
    $osc_3.set_waveform($program_table[i + 4])
    $osc_3.set_coarse_tune($program_table[i + 5])
    $osc_3.set_fine_tune($program_table[i + 6])
    $filter.set_cutoff($program_table[i + 7])
    $filter.set_resonance($program_table[i + 8])
    $filter.set_envelope($program_table[i + 9])
    $eg.set_attack($program_table[i + 10])
    $eg.set_decay_release($program_table[i + 11])
    $eg.set_sustain($program_table[i + 12])
  end
end
