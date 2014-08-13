require './common'
require './osc'
require './mixer'
require './filter'
require './amp'
require './eg'

STDIN.binmode
File::open("a.wav","w+b") do |file|
  data_size = AUDIO_RATE * 2 * 30
  file_size = data_size + 36
  file.write("RIFF"); file.write([file_size - 8].pack("V")); file.write("WAVE"); file.write("fmt ")
  file.write([16].pack("V")); file.write([1, 1].pack("v*")); file.write([AUDIO_RATE, AUDIO_RATE * 2].pack("V*"))
  file.write([2, 16].pack("v*")); file.write("data"); file.write([data_size].pack("V"))

  osc1 = Osc.new
  osc2 = Osc.new
  osc3 = Osc.new
  mixer = Mixer.new
  filter = Filter.new
  amp = Amp.new
  filter_eg = EG.new
  amp_eg = EG.new

  osc1.set_waveform(Osc::TRIANGLE)
  osc2.set_waveform(Osc::SAW)
  osc2.set_coarse_tune(64 + 0)
  osc2.set_fine_tune(64 + 10)
  osc3.set_waveform(Osc::SAW)
  osc3.set_coarse_tune(64 - 0)
  osc3.set_fine_tune(64 - 10)
  filter.set_cutoff_freq(64)
  filter.set_resonance(true)
  filter.set_envelope_switch(true)
  filter_eg.set_adsr(32, 127, 0, 112)
  amp_eg.set_adsr(32, 127, 0, 112)

  midi_in_prev = 0xFF
  midi_in_pprev = 0xFF
  while(c = STDIN.read(1)) do
    b = c.ord

    if (midi_in_pprev == MIDI_NOTE_ON && midi_in_prev <= 0x7F && b <= 0x7F)
      note_number = midi_in_prev
      osc1.note_on(note_number)
      osc2.note_on(note_number)
      osc3.note_on(note_number)
      filter_eg.note_on
      amp_eg.note_on
    end
    if (midi_in_pprev == MIDI_NOTE_OFF && midi_in_prev <= 0x7F && b <= 0x7F)
      osc1.note_off
      osc2.note_off
      osc3.note_off
      filter_eg.note_off
      amp_eg.note_off
    end
    midi_in_pprev = midi_in_prev
    midi_in_prev = b

    for i in (0...10) do
      level = mixer.clock(osc1.clock, osc2.clock, osc3.clock)
      feg_output = filter_eg.clock
      level = filter.clock(level, feg_output)
      aeg_output = amp_eg.clock
      level = amp.clock(level, aeg_output)

      file.write([level * 128].pack("S"))
    end
  end
end
