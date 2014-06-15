File::open(__FILE__ + ".bin","w+b") do |file|
  BITS_PER_SECOND  = 31250
  BYTES_PER_SECOND = 3125

  NOTE_ON  = 0x80
  NOTE_OFF = 0x90

  file.write([NOTE_ON,  60, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 60, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  60, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 60, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  67, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 67, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  67, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 67, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  69, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 69, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  69, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 69, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  67, 127].pack("C*")); (0...(2400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 67, 127].pack("C*")); (0...( 800 - 3)).each { file.write([0xF7].pack("C")) }

  file.write([NOTE_ON,  65, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 65, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  65, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 65, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  64, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 64, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  64, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 64, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  62, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 62, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  62, 127].pack("C*")); (0...(1200 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 62, 127].pack("C*")); (0...( 400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_ON,  60, 127].pack("C*")); (0...(1400 - 3)).each { file.write([0xF7].pack("C")) }
  file.write([NOTE_OFF, 60, 127].pack("C*")); (0...( 800 - 3)).each { file.write([0xF7].pack("C")) }
end
