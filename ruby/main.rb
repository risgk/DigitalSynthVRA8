require './common'
require './midi_in'
require './osc'
require './mixer'
require './filter'
require './amp'
require './eg'

$osc1 = Osc.new
$osc2 = Osc.new
$osc3 = Osc.new
$mixer = Mixer.new
$filter = Filter.new
$amp = Amp.new
$eg = EG.new
$midi_in = MIDIIn.new

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

File::open(ARGV[0], "rb") do |bin_file|
  File::open("a.wav", "wb") do |wav_file|
    data_size = AUDIO_RATE * 2 * 30
    file_size = data_size + 36
    wav_file.write("RIFF"); wav_file.write([file_size - 8].pack("V")); wav_file.write("WAVE"); wav_file.write("fmt ")
    wav_file.write([16].pack("V")); wav_file.write([1, 1].pack("v*")); wav_file.write([AUDIO_RATE, AUDIO_RATE * 2].pack("V*"))
    wav_file.write([2, 16].pack("v*")); wav_file.write("data"); wav_file.write([data_size].pack("V"))

    midi_in_prev = MIDI_EOX
    midi_in_pprev = MIDI_EOX
    while(c = bin_file.read(1)) do
      b = c.ord

      # todo: running status, control change, program change, system messages
      if (midi_in_pprev == MIDI_NOTE_ON && midi_in_prev <= MIDI_DATA_BYTE_MAX &&
          b <= MIDI_DATA_BYTE_MAX && b >= 0x01)
        note_number = midi_in_prev
        $osc1.note_on(note_number)
        $osc2.note_on(note_number)
        $osc3.note_on(note_number)
        $eg.note_on
      end
      if ((midi_in_pprev == MIDI_NOTE_ON  && midi_in_prev <= MIDI_DATA_BYTE_MAX && b == 0x00) ||
          (midi_in_pprev == MIDI_NOTE_OFF && midi_in_prev <= MIDI_DATA_BYTE_MAX && b <= MIDI_DATA_BYTE_MAX))
        $osc1.note_off
        $osc2.note_off
        $osc3.note_off
        $eg.note_off
      end
      midi_in_pprev = midi_in_prev
      midi_in_prev = b

      for i in (0...10) do
        level = $mixer.clock($osc1.clock, $osc2.clock, $osc3.clock)
        eg_output = $eg.clock
        level = $filter.clock(level, eg_output)
        level = $amp.clock(level, eg_output)

        wav_file.write([level * 128].pack("S"))
      end
    end
  end
end
