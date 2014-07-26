STDIN.binmode
File::open(__FILE__ + ".wav","w+b") do |file|
  sample_rate = 31250

  wavemem_resolution = 32
  wavemem_sine     = [0,0,1,3,5,7,10,12,16,19,21,24,26,28,30,31,31,31,30,28,26,24,21,19,16,12,10,7,5,3,1,0]
  wavemem_triangle = [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,31,29,27,25,23,21,19,17,15,13,11,9,7,5,3,1]
  wavemem_saw      = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
  wavemem_square   = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31]
  wavemem_square_4 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,31]
  wavemem_square_8 = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31]
  wavemems = [wavemem_sine,wavemem_triangle,wavemem_saw,wavemem_square,wavemem_square_4,wavemem_square_8]

  envelope_lead = [50,1000,15,250]
  envelope_resolution = 32
  A = 0
  D = 1
  S = 2
  R = 3

  scales = [
     7.46484375, 7.04296875, 6.64843750, 6.27734375, 5.92187500, 5.58984375, 5.27734375, 4.98046875, 4.69921875, 4.43750000, 4.18750000, 3.95312500, # C3-
     3.73046875, 3.51953125, 3.32421875, 3.13671875, 2.96093750, 2.79296875, 2.63671875, 2.48828125, 2.34765625, 2.21875000, 2.09375000, 1.97656250, # C4-
     1.86328125, 1.75781250, 1.66015625, 1.56640625, 1.48046875, 1.39453125, 1.31640625, 1.24218750, 1.17187500, 1.10937500, 1.04687500, 0.98828125, # C5-
  ]

  data_size = sample_rate * 8
  file_size = data_size + 36
  file.write("RIFF")
  file.write([file_size - 8].pack("V"))
  file.write("WAVE")
  file.write("fmt ")
  file.write([16].pack("V"))
  file.write([1].pack("v"))
  file.write([1].pack("v"))
  file.write([sample_rate].pack("V"))
  file.write([sample_rate].pack("V"))
  file.write([1].pack("v"))
  file.write([8].pack("v"))
  file.write("data")
  file.write([data_size].pack("V"))

  wavemem = wavemem_saw
  wavemem_step = 0
  envelope = envelope_lead
  envelope_generator_level = 0
  lfo_wavemem = wavemem_triangle
  lfo_wavemem_step = 16

  NOTE_ON  = 0x80
  NOTE_OFF = 0x90

  note_number = 60
  count_per_wavemem_step = scales[note_number - 48]
  wavemem_current_step_rest = count_per_wavemem_step
  envelope_generator_state = A
  envelope_generator_rest = 0
  lfo_rest = (sample_rate * 1 / 2)
  lfo_wavemem_step = 16

  prev = 0xFF
  pprev = 0xFF
  while(str = STDIN.read(1)) do
    c = str.ord

    if pprev == NOTE_ON && prev <= 0x7F && c <= 0x7F
      note_number = prev
      count_per_wavemem_step = scales[note_number - 48]
      wavemem_current_step_rest = count_per_wavemem_step
      envelope_generator_state = A
      envelope_generator_rest = envelope[envelope_generator_state]
    end
    if pprev == NOTE_OFF && prev <= 0x7F && c <= 0x7F
      envelope_generator_state = R
      envelope_generator_rest = envelope[envelope_generator_state]
    end
    pprev = prev
    prev = c

    (0...10).each do
      lfo_rest -= 1
      while (lfo_rest <= 0)
        lfo_rest = lfo_rest + (sample_rate / envelope_resolution / 4)
        lfo_wavemem_step += 1
        lfo_wavemem_step %= wavemem_resolution
      end

      wavemem_current_step_rest -= 1
      while (wavemem_current_step_rest <= 0)
        wavemem_current_step_rest = wavemem_current_step_rest + 
                                    count_per_wavemem_step *
                                    (lfo_wavemem[lfo_wavemem_step] - 16 + 2048) / 2048.0
        wavemem_step += 1
        wavemem_step %= wavemem_resolution
      end

      envelope_generator_rest -= 1
      case envelope_generator_state
      when A
        if envelope_generator_rest <= 0
          if envelope_generator_level < envelope_resolution
            envelope_generator_level += 1
            envelope_generator_rest = envelope[envelope_generator_state]
          else
            envelope_generator_state = D
            envelope_generator_rest = envelope[envelope_generator_state]
          end
        end
      when D
        if envelope_generator_rest <= 0
          if envelope_generator_level > envelope[2]
            envelope_generator_level -= 1
            envelope_generator_rest = envelope[envelope_generator_state]
          else
            envelope_generator_state = S
            envelope_generator_rest = 9999
          end
        end
      when S
      when R
        if envelope_generator_rest <= 0
          if envelope_generator_level > 0
            envelope_generator_level -= 1
            envelope_generator_rest = envelope[envelope_generator_state]
          else
            envelope_generator_level = 0
            envelope_generator_rest = 9999
          end
        end
      end

      level = wavemem[wavemem_step] *
              envelope_generator_level / envelope_resolution
      file.write([0x80 + level].pack("C"))
    end
  end
end
