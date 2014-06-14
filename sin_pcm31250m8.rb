File::open(__FILE__ + ".wav","w+b") {|file|
  tone_freq = 440
  sampling_freq = 31250
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

  wave = [0,0,1,3,5,7,10,12,16,19,21,24,26,28,30,31,31,31,30,28,26,24,21,19,16,12,10,7,5,3,1,0]
  count_per_step = sampling_freq / tone_freq / 32

  step = 0
  rest = count_per_step
  (0...sampling_freq).each{
    rest = rest - 1
    if rest == 0
      rest = count_per_step
      step = (step + 1) % 32
    end
    file.write([0x80 + wave[step]].pack("C"))
  }
}
