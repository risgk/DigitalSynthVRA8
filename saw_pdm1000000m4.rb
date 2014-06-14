File::open(__FILE__ + ".wav","w+b") {|file|
  tone_freq = 440
  sampling_freq = 62500
  dynamic_range = 16
  base_freq = sampling_freq * dynamic_range
  data_size = base_freq
  file_size = data_size + 36

  file.write("RIFF")
  file.write([file_size - 8].pack("V"))
  file.write("WAVE")
  file.write("fmt ")
  file.write([16].pack("V"))
  file.write([1].pack("v"))
  file.write([1].pack("v"))
  file.write([base_freq].pack("V"))
  file.write([base_freq].pack("V"))
  file.write([1].pack("v"))
  file.write([8].pack("v"))
  file.write("data")
  file.write([data_size].pack("V"))

  (0...sampling_freq).each{ |i|
    tone_period = sampling_freq / tone_freq
    l = (dynamic_range - 1) * (i % tone_period) / tone_period
    (0...l).each {
      file.write([0xC0].pack("C"))
    }
    (l...dynamic_range).each {
      file.write([0x80].pack("C"))
    }
  }
}
