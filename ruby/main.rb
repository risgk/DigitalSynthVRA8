require './common'
require './midi_in'
require './synth'

$midi_in = MIDIIn.new
$synth = Synth.new

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
        $synth.note_on(note_number)
      end
      if ((midi_in_pprev == MIDI_NOTE_ON  && midi_in_prev <= MIDI_DATA_BYTE_MAX && b == 0x00) ||
          (midi_in_pprev == MIDI_NOTE_OFF && midi_in_prev <= MIDI_DATA_BYTE_MAX && b <= MIDI_DATA_BYTE_MAX))
        $synth.note_off
      end
      midi_in_pprev = midi_in_prev
      midi_in_prev = b

      for i in (0...10) do
        level = $synth.clock
        wav_file.write([level * 128].pack("S"))
      end
    end
  end
end
