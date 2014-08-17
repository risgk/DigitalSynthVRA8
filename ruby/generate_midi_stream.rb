require './common'

$file = File::open("midi_stream.bin", "wb")

def program_change(program_number)
    $file.write([MIDI_PROGRAM_CHANGE, program_number].pack("C*"))
end

def play(note_number, length)
  $file.write([MIDI_NOTE_ON,  note_number, 64].pack("C*"))
  (length * 7 / 8).times { $file.write([MIDI_ACTIVE_SENSING].pack("C")) }
  $file.write([MIDI_NOTE_OFF, note_number, 64].pack("C*"))
  (length * 1 / 8).times { $file.write([MIDI_ACTIVE_SENSING].pack("C")) }
end

def wait(length)
  length.times { $file.write([MIDI_ACTIVE_SENSING].pack("C")) }
end

def play_cedfgabc(c)
  play(12 + (c * 12), 1000)
  play(14 + (c * 12), 1000)
  play(16 + (c * 12), 1000)
  play(17 + (c * 12), 1000)
  play(19 + (c * 12), 1000)
  play(21 + (c * 12), 1000)
  play(23 + (c * 12), 1000)
  play(24 + (c * 12), 4000)
  wait(1000)
end

program_change(PC_SUB_OSC_LEAD)
play_cedfgabc(3)

program_change(PC_SAW_LEAD)
play_cedfgabc(3)

program_change(PC_SQUERE_LEAD)
play_cedfgabc(4)

program_change(PC_SYNTH_PAD)
play_cedfgabc(4)

program_change(PC_SYNTH_BASS)
play_cedfgabc(2)
