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

  wave = [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,31,29,27,25,23,21,19,17,15,13,11,9,7,5,3,1]
  count_per_step = sampling_freq / tone_freq / 32

  step = 0
  rest = count_per_step
  (0...sampling_freq).each{
    rest = rest - 1
    if rest == 0
      rest = count_per_step
      step = (step + 1) % 32
    end
    file.write([0x80 + wave[step] * 4].pack("C"))
  }
}
