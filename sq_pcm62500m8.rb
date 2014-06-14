File::open(__FILE__ + ".wav","w+b") {|file|
  tone_freq = 440
  sampling_freq = 62500
  data_size = sampling_freq
  file_size = data_size + 36

  file.write("RIFF")
  file.write([file_size - 8].pack("V"))
  file.write("WAVE")
  file.write("fmt ")
  file.write([16].pack("V"))
  file.write([1].pack("v"))
  file.write([1].pack("v"))
  file.write([sampling_freq].pack("V"))
  file.write([sampling_freq].pack("V"))
  file.write([1].pack("v"))
  file.write([8].pack("v"))
  file.write("data")
  file.write([data_size].pack("V"))

  (0...sampling_freq).each{ |i|
    if (i % (sampling_freq / tone_freq) >= ((sampling_freq / tone_freq) / 2))
      file.write([0xA0].pack("C"))
    else
      file.write([0x80].pack("C"))
    end
  }
}
