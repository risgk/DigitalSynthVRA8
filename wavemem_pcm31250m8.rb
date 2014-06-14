File::open(__FILE__ + ".wav","w+b") {|file|
  wavemem_resolution = 32
  wavemem_sine     = [0,0,1,3,5,7,10,12,16,19,21,24,26,28,30,31,31,31,30,28,26,24,21,19,16,12,10,7,5,3,1,0]
  wavemem_triangle = [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,31,29,27,25,23,21,19,17,15,13,11,9,7,5,3,1]
  wavemem_saw      = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
  wavemem_square   = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31]
  wavemem_square_4 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,31]
  wavemem_square_8 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31]
  wavemems = [wavemem_sine,wavemem_triangle,wavemem_saw,wavemem_square,wavemem_square_4,wavemem_square_8]

  tone_freq = 440
  sampling_freq = 31250
  data_size = sampling_freq * wavemems.length
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

  wavemems.each { |wavemem|
    count_per_step = sampling_freq / tone_freq / wavemem_resolution

    step = 0
    rest = count_per_step
    (0...sampling_freq).each{
      rest = rest - 1
      if rest == 0
        rest = count_per_step
        step = (step + 1) % wavemem_resolution
      end
      level = wavemem[step]
      file.write([0x80 + level * 2].pack("C"))
    }
  }
}
