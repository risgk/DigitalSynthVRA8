require './common'
require './oscillator'
require './mixer'
require './filter'
require './amplifier'
require './eg'

AUDIO_RATE = 31250; PWM_RATE = 31250
MIDI_NOTE_ON = 0x80; MIDI_NOTE_OFF = 0x90

STDIN.binmode
File::open("a.wav","w+b") do |file|
  data_size = AUDIO_RATE * 2 * 30
  file_size = data_size + 36
  file.write("RIFF"); file.write([file_size - 8].pack("V")); file.write("WAVE"); file.write("fmt ")
  file.write([16].pack("V")); file.write([1, 1].pack("v*")); file.write([AUDIO_RATE, AUDIO_RATE * 2].pack("V*"))
  file.write([2, 16].pack("v*")); file.write("data"); file.write([data_size].pack("V"))

  oscillator1 = Oscillator.new
  oscillator2 = Oscillator.new
  oscillator3 = Oscillator.new
  mixer = Mixer.new
  filter = Filter.new
  amplifier = Amplifier.new
  eg = EG.new

  oscillator1.set_waveform(Oscillator::WAVEFORM_SQUARE)
  oscillator2.set_waveform(Oscillator::WAVEFORM_SAW)
  oscillator3.set_waveform(Oscillator::WAVEFORM_SAW)
  oscillator1.set_fine_tune(0x4A)
  oscillator2.set_fine_tune(0x36)

  midi_in_prev = 0xFF
  midi_in_pprev = 0xFF
  while(c = STDIN.read(1)) do
    b = c.ord

    if (midi_in_pprev == MIDI_NOTE_ON && midi_in_prev <= 0x7F && b <= 0x7F)
      note_number = midi_in_prev
      oscillator1.note_on(note_number)
      oscillator2.note_on(note_number)
      oscillator3.note_on(note_number)
      eg.note_on
    end
    if (midi_in_pprev == MIDI_NOTE_OFF && midi_in_prev <= 0x7F && b <= 0x7F)
      oscillator1.note_off
      oscillator2.note_off
      oscillator3.note_off
      eg.note_on
    end
    midi_in_pprev = midi_in_prev
    midi_in_prev = b

    for i in (0...10) do
      level = mixer.clock(oscillator1.clock, oscillator2.clock, oscillator3.clock, 0x80)
      eg_output = eg.clock
      level = filter.clock(level, eg_output)
#     level = amplifier.clock(level, eg_output)

      file.write([(level - 128) * 64].pack("S"))
    end
  end
end
