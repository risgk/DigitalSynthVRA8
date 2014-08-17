require './common'

File::open("midi_stream.bin", "wb") do |f|
  (1..4).each do |i|
    f.write([MIDI_NOTE_ON,  24 + (i * 12), 127].pack("C*"))
    900.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 24 + (i * 12), 127].pack("C*"))
    100.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_ON,  26 + (i * 12), 127].pack("C*"))
    900.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 26 + (i * 12), 127].pack("C*"))
    100.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_ON,  28 + (i * 12), 127].pack("C*"))
    900.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 28 + (i * 12), 127].pack("C*"))
    100.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_ON,  29 + (i * 12), 127].pack("C*"))
    900.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 29 + (i * 12), 127].pack("C*"))
    100.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_ON,  31 + (i * 12), 127].pack("C*"))
    900.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 31 + (i * 12), 127].pack("C*"))
    100.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_ON,  33 + (i * 12), 127].pack("C*"))
    900.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 33 + (i * 12), 127].pack("C*"))
    100.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_ON,  35 + (i * 12), 127].pack("C*"))
    900.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 35 + (i * 12), 127].pack("C*"))
    100.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_ON,  36 + (i * 12), 127].pack("C*"))
    3600.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    f.write([MIDI_NOTE_OFF, 36 + (i * 12), 127].pack("C*"))
    400.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
    2000.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
  end
  2000.times { f.write([MIDI_ACTIVE_SENSING].pack("C")) }
end
