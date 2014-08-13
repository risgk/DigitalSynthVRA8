File::open("midi.bin","w+b") do |file|
  BITS_PER_SECOND  = 31250
  BYTES_PER_SECOND = 3125

  NOTE_ON  = 0x80
  NOTE_OFF = 0x90

  (0..5).each do |i|
    file.write([NOTE_ON,  24 + i * 12, 127].pack("C*")); (0...(4000 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_OFF, 24 + i * 12, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_ON,  26 + i * 12, 127].pack("C*")); (0...(1000 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_OFF, 26 + i * 12, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_ON,  28 + i * 12, 127].pack("C*")); (0...(1000 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_OFF, 28 + i * 12, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_ON,  29 + i * 12, 127].pack("C*")); (0...(1000 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_OFF, 29 + i * 12, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_ON,  31 + i * 12, 127].pack("C*")); (0...(1000 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_OFF, 31 + i * 12, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_ON,  33 + i * 12, 127].pack("C*")); (0...(1000 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_OFF, 33 + i * 12, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_ON,  35 + i * 12, 127].pack("C*")); (0...(1000 - 3)).each { file.write([0xF7].pack("C")) }
    file.write([NOTE_OFF, 35 + i * 12, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
  end

  file.write([NOTE_ON,  96, 127].pack("C*")); (0...(4000 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 96, 127].pack("C*")); (0...( 500 - 3)).each { file.write([0xF7].pack("C")) }
  (0...10000).each { file.write([0xF7].pack("C")) }
end
