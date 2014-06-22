STDIN.binmode
File::open(__FILE__ + ".wav","w+b") do |file|
  sample_rate = 31250

  wavemem_num_steps = 32
  wavemem_triangle = [7, 6, 5, 4, 3, 2, 1, 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 15, 14, 13, 12, 11, 10, 9, 8]
  wavemem_saw      = [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15]
  wavemem_square   = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15]
  wavemem_square_4 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0]
  wavemem_square_8 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  wavemem_lfo      = [8, 9, 10, 11, 12, 13, 14, 15, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0, 1, 2, 3, 4, 5, 6, 7]

  envelope_lead = [50,1000,15,250]
  envelope_level_max = 16
  A = 0
  D = 1
  S = 2
  R = 3

  # C1..B7
  scales = [
    30578, 28861, 27241, 25712, 24269, 22907, 21621, 20408, 19262, 18181, 17161, 16198,
    15289, 14430, 13620, 12856, 12134, 11453, 10810, 10204, 9631, 9090, 8580, 8099,
    7644, 7215, 6810, 6428, 6067, 5726, 5405, 5102, 4815, 4545, 4290, 4049,
    3822, 3607, 3405, 3214, 3033, 2863, 2702, 2551, 2407, 2272, 2145, 2024,
    1911, 1803, 1702, 1607, 1516, 1431, 1351, 1275, 1203, 1136, 1072, 1012,
    955, 901, 851, 803, 758, 715, 675, 637, 601, 568, 536, 506,
    477, 450, 425, 401, 379, 357, 337, 318, 300, 284, 268, 253,
    238, 225, 212, 200, 189, 178, 168, 159, 150, 142, 134, 126,
    119, 112, 106, 100, 94, 89, 84, 79, 75, 71, 67, 63,
    59, 56, 53, 50, 47, 44, 42, 39, 37, 35, 33, 31,
    29, 28, 26, 25, 23, 22, 21, 19
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
  lfo_wavemem = wavemem_lfo
  lfo_wavemem_step = 16

  NOTE_ON  = 0x80
  NOTE_OFF = 0x90

  note_number = 60
  count_per_wavemem_step = scales[note_number]
  wavemem_current_step_rest = count_per_wavemem_step
  envelope_generator_state = A
  envelope_generator_rest = 0
  lfo_rest = (sample_rate * 1 / 2)
  lfo_wavemem_step = 0

  prev = 0xFF
  pprev = 0xFF
  while(str = STDIN.read(1)) do
    c = str.ord

    if pprev == NOTE_ON && prev <= 0x7F && c <= 0x7F
      note_number = prev
      count_per_wavemem_step = scales[note_number]
      wavemem_current_step_rest = count_per_wavemem_step
      envelope_generator_state = A
      envelope_generator_rest = envelope[envelope_generator_state]
      lfo_rest = (sample_rate * 1 / 2)
      lfo_wavemem_step = 0
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
        lfo_rest = lfo_rest + (sample_rate / 16 / 4)
        lfo_wavemem_step += 1
        lfo_wavemem_step %= wavemem_num_steps
      end

      wavemem_current_step_rest -= 256
      while (wavemem_current_step_rest <= 0)
        wavemem_current_step_rest = wavemem_current_step_rest + 
                                    count_per_wavemem_step *
                                    (lfo_wavemem[lfo_wavemem_step] - 8 + 1024) / 1024.0
        wavemem_step += 1
        wavemem_step %= wavemem_num_steps
      end

      envelope_generator_rest -= 1
      case envelope_generator_state
      when A
        if envelope_generator_rest <= 0
          if envelope_generator_level < envelope_level_max
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
              envelope_generator_level / envelope_level_max
      file.write([0x80 + level * 2].pack("C"))
    end
  end
end
