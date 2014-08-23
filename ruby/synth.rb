require './common'
require './program_table'
require './vco'
require './vcf'
require './vca'
require './eg'
require './mixer'

$vco_1 = VCO.new
$vco_2 = VCO.new
$vco_3 = VCO.new
$vcf = VCF.new
$vca = VCA.new
$eg = EG.new
$mixer = Mixer.new

class Synth
  def initialize
    @running_status = ACTIVE_SENSING
    @midi_in_prev = ACTIVE_SENSING
    @midi_in_pprev = ACTIVE_SENSING
    @note_number = 60
    program_change(0)
  end

  def receive_midi_byte(b)
    # todo: running status, control change, program change, system messages
    if (@midi_in_pprev == NOTE_ON && @midi_in_prev <= DATA_BYTE_MAX &&
        b <= DATA_BYTE_MAX && b >= 0x01)
      note_on(@midi_in_prev)
    elsif ((@midi_in_pprev == NOTE_ON && @midi_in_prev <= DATA_BYTE_MAX && b == 0x00) ||
        (@midi_in_pprev == NOTE_OFF && @midi_in_prev <= DATA_BYTE_MAX && b <= DATA_BYTE_MAX))
      note_off(@midi_in_prev)
    elsif (@midi_in_prev == PROGRAM_CHANGE && b <= DATA_BYTE_MAX)
      program_change(b)
    end
    @midi_in_pprev = @midi_in_prev
    @midi_in_prev = b
  end

  def clock
    level = $mixer.clock($vco_1.clock, $vco_2.clock, $vco_3.clock)
    eg_output = $eg.clock
    level = $vcf.clock(level, eg_output)
    level = $vca.clock(level, eg_output)
  end

  private
  def real_time_message?(b)
    b >= REAL_TIME_MIN
  end

  def system_message?(b)
    b >= SYSTEM_MIN
  end

  def data_byte?(b)
    b <= DATA_BYTE_MAX
  end

  def note_on(note_number)
    # special: program toggle
    if (note_number == PROGRAM_TOGGLE_NOTE_NUMBER)
      program_number = @program_number + 1
      if (program_number > PROGRAM_NUMBER_MAX)
        program_number = 0
      end
      program_change(program_number)
      return
    end

    @note_number = note_number
    $vco_1.note_on(@note_number)
    $vco_2.note_on(@note_number)
    $vco_3.note_on(@note_number)
    $eg.note_on(@note_number)
  end

  def note_off(note_number)
    if note_number == @note_number
      $eg.note_off(@note_number)
    end
  end

  def sound_off
    $vco_1.sound_off
    $vco_2.sound_off
    $vco_3.sound_off
    $eg.sound_off
  end

  def control_change(controller_number, value)
    case (controller_number)
    when VCO1_WAVEFORM
      set_vco1_waveform(value)
    when VCO2_WAVEFORM
      set_vco2_waveform(value)
    when VCO2_COARSE_TUNE
      set_vco2_coarse_tune(value)
    when VCO2_FINE_TUNE
      set_vco2_fine_tune(value)
    when VCO3_WAVEFORM
      set_vco3_waveform(value)
    when VCO3_COARSE_TUNE
      set_vco3_coarse_tune(value)
    when VCO3_FINE_TUNE
      set_vco3_fine_tune(value)
    when VCF_CUTOFF
      set_filter_cutoff(value)
    when VCF_RESONANCE
      set_filter_resonance(value)
    when VCF_ENVELOPE
      set_filter_envelope(value)
    when EG_ATTACK
      set_eg_attack(value)
    when EG_DECAY_RELEASE
      set_decay_release(value)
    when EG_SUSTAIN
      set_eg_sustain(value)
    end
  end

  def set_vco1_waveform(value)
    sound_off
    $vco_1.set_waveform(value)
  end

  def set_vco2_waveform(value)
    sound_off
    $vco_2.set_waveform(value)
  end

  def set_vco2_coarse_tune(value)
    sound_off
    $vco_2.set_coarse_tune(value)
  end

  def set_vco2_fine_tune(value)
    sound_off
    $vco_2.set_fine_tune(value)
  end

  def set_vco3_waveform(value)
    sound_off
    $vco_3.set_waveform(value)
  end

  def set_vco3_coarse_tune(value)
    sound_off
    $vco_3.set_coarse_tune(value)
  end

  def set_vco3_fine_tune(value)
    sound_off
    $vco_3.set_fine_tune(value)
  end

  def set_filter_cutoff(value)
    $vcf.set_cutoff(value)
  end

  def set_filter_resonance(value)
    $vcf.set_resonance(value)
  end

  def set_filter_envelope(value)
    $vcf.set_envelope(value)
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
    $vco_1.set_waveform($program_table[i + 0])
    $vco_1.set_coarse_tune(64)
    $vco_1.set_fine_tune(64)
    $vco_2.set_waveform($program_table[i + 1])
    $vco_2.set_coarse_tune($program_table[i + 2])
    $vco_2.set_fine_tune($program_table[i + 3])
    $vco_3.set_waveform($program_table[i + 4])
    $vco_3.set_coarse_tune($program_table[i + 5])
    $vco_3.set_fine_tune($program_table[i + 6])
    $vcf.set_cutoff($program_table[i + 7])
    $vcf.set_resonance($program_table[i + 8])
    $vcf.set_envelope($program_table[i + 9])
    $eg.set_attack($program_table[i + 10])
    $eg.set_decay_release($program_table[i + 11])
    $eg.set_sustain($program_table[i + 12])
  end
end
