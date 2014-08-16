require './common'
require './program_table'
require './osc'
require './mixer'
require './eg'
require './filter'
require './amp'

$osc1 = Osc.new
$osc2 = Osc.new
$osc3 = Osc.new
$mixer = Mixer.new
$eg = EG.new
$filter = Filter.new
$amp = Amp.new

class Synth
  def initialize
    $osc1.set_waveform(WAVEFORM_TRIANGLE)
    $osc2.set_waveform(WAVEFORM_SAW)
    $osc2.set_coarse_tune(64 + 0)
    $osc2.set_fine_tune(64 + 10)
    $osc3.set_waveform(WAVEFORM_SAW)
    $osc3.set_coarse_tune(64 - 0)
    $osc3.set_fine_tune(64 - 10)
    $filter.set_cutoff(64)
    $filter.set_resonance(127)
    $filter.set_envelope(127)
    $eg.set_adsr(32, 127, 0, 112)
  end

  def note_on(note_number)
    $osc1.note_on(note_number)
    $osc2.note_on(note_number)
    $osc3.note_on(note_number)
    $eg.note_on
  end

  def note_off
    $osc1.note_off
    $osc2.note_off
    $osc3.note_off
    $eg.note_off
  end

  def control_change(controller_number, value)
    # todo
  end

  def program_change(program_number)
    # todo
  end

  def clock
    level = $mixer.clock($osc1.clock, $osc2.clock, $osc3.clock)
    eg_output = $eg.clock
    level = $filter.clock(level, eg_output)
    level = $amp.clock(level, eg_output)
  end
end
