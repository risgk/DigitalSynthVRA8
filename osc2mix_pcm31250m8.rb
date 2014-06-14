File::open(__FILE__ + ".wav","w+b") {|file|
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
  envelope_level_max = envelope_resolution - 1
  A = 0
  D = 1
  S = 2
  R = 3

  scales = [
#   29.85937500,28.18359375,26.60156250,25.10937500,23.69921875,22.36718750,21.11328125,19.92968750,18.80859375,17.75390625,16.75781250,15.81640625, # C1-
#   14.92968750,14.08984375,13.30078125,12.55468750,11.84765625,11.18359375,10.55468750, 9.96484375, 9.40234375, 8.87500000, 8.37890625, 7.90625000, # C2-
     7.46484375, 7.04296875, 6.64843750, 6.27734375, 5.92187500, 5.58984375, 5.27734375, 4.98046875, 4.69921875, 4.43750000, 4.18750000, 3.95312500, # C3-
     3.73046875, 3.51953125, 3.32421875, 3.13671875, 2.96093750, 2.79296875, 2.63671875, 2.48828125, 2.34765625, 2.21875000, 2.09375000, 1.97656250, # C4-
     1.86328125, 1.75781250, 1.66015625, 1.56640625, 1.48046875, 1.39453125, 1.31640625, 1.24218750, 1.17187500, 1.10937500, 1.04687500, 0.98828125, # C5-
#    0.92968750, 0.87890625, 0.82812500, 0.78125000, 0.73828125, 0.69531250, 0.65625000, 0.62109375, 0.58593750, 0.55468750, 0.52343750, 0.49218750, # C6-
  ]

  tempo = 120
  Q = sample_rate * 60 / tempo
  H = Q * 2
  W = Q * 4
  melody = [
    [60, Q],[60, Q],[67, Q],[67, Q],
    [69, Q],[69, Q],[67, H],
    [65, Q],[65, Q],[64, Q],[64, Q],
    [62, Q],[62, Q],[60, H]
  ]

  data_size = sample_rate * 8 * 120 / tempo
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
  wavemem_sub = wavemem_square
  wavemem_step = 0
  envelope = envelope_lead
  envelope_generator_level = 0

  melody.each { |note_number, length|
    count_per_wavemem_step = scales[note_number - 48]
    wavemem_current_step_rest_count = count_per_wavemem_step
    envelope_generator_state = A
    envelope_generator_rest = envelope[envelope_generator_state]
    (0...length).each{ |count|
      wavemem_current_step_rest_count -= 1
      while (wavemem_current_step_rest_count <= 0)
        wavemem_current_step_rest_count = wavemem_current_step_rest_count + count_per_wavemem_step
        wavemem_step += 1
        wavemem_step %= wavemem_resolution
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

      mix_sub = 0
      if count > sample_rate * 3 / 4
        mix_sub = 31
      elsif count > sample_rate / 4
        mix_sub = (count - sample_rate / 4) * 31 / (sample_rate / 2)
      end
      wavemem_step_sub = wavemem_step + 0 # phase shift
      wavemem_step_sub %= wavemem_resolution
      level = (wavemem[wavemem_step] * (31 - mix_sub) / 31 +
               wavemem_sub[wavemem_step_sub] * mix_sub / 31) *
              envelope_generator_level / envelope_level_max
      file.write([0x80 + level].pack("C"))

      if (envelope_generator_state <= 2) && (count >= (length * 3) / 4)
        envelope_generator_state = 3
        envelope_generator_rest = envelope[envelope_generator_state]
      end
    }
  }
}
