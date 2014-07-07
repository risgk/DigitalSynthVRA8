AUDIO_RATE = 31250
CONTROL_PERIOD = 520 # 60.1 Hz

note_number_to_count = [
    0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF,
    0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF,
    0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF,
    0x0EEE, 0x0E17, 0x0D4D, 0x0C8E, 0x0BD9, 0x0B2F, 0x0A8E, 0x09F7, 0x0967, 0x08E0, 0x0861, 0x07E8, # C2 - B2
    0x0777, 0x070B, 0x06A6, 0x0647, 0x05EC, 0x0597, 0x0547, 0x04FB, 0x04B3, 0x0470, 0x0430, 0x03F4, # C3 - B3
    0x03BB, 0x0385, 0x0353, 0x0323, 0x02F6, 0x02CB, 0x02A3, 0x027D, 0x0259, 0x0238, 0x0218, 0x01FA, # C4 - B4
    0x01DD, 0x01C2, 0x01A9, 0x0191, 0x017B, 0x0165, 0x0151, 0x013E, 0x012C, 0x011C, 0x010C, 0x00FD, # C5 - B5
    0x00EE, 0x00E1, 0x00D4, 0x00C8, 0x00BD, 0x00B2, 0x00A8, 0x009F, 0x0096, 0x008E, 0x0FFF, 0x0FFF, # C6 - A6
    0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF,
    0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF,
    0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF, 0x0FFF,
]

wave_num_steps = 32
wave_saw = [
    0xF, 0xF, 0xE, 0xE, 0xD, 0xD, 0xC, 0xC, 0xB, 0xB, 0xA, 0xA, 0x9, 0x9, 0x8, 0x8,
    0x7, 0x7, 0x6, 0x6, 0x5, 0x5, 0x4, 0x4, 0x3, 0x3, 0x2, 0x2, 0x1, 0x1, 0x0, 0x0,
]
wave_pulse_1_2 = [
    0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
]
wave_tri = [
    0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0xF, 0xE, 0xD, 0xC, 0xB, 0xA, 0x9, 0x8,
    0x7, 0x6, 0x5, 0x4, 0x3, 0x2, 0x1, 0x0, 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
]
wave_pulse_1_4 = [
    0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
]
wave_pulse_1_8 = [
    0xF, 0xF, 0xF, 0xF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
]
wave_lfo = [
    0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0xF, 0xE, 0xD, 0xC, 0xB, 0xA, 0x9, 0x8,
    0x7, 0x6, 0x5, 0x4, 0x3, 0x2, 0x1, 0x0, 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
]
wave = wave_saw

envelope_lead = [10,100,15,20]
envelope_level_max = 15
A = 0
D = 1
S = 2
R = 3

STDIN.binmode
File::open(__FILE__ + ".wav","w+b") do |file|
    data_size = 2 * AUDIO_RATE * 9
    file_size = data_size + 36
    file.write("RIFF")
    file.write([file_size - 8].pack("V"))
    file.write("WAVE")
    file.write("fmt ")
    file.write([16].pack("V"))
    file.write([1].pack("v"))
    file.write([1].pack("v"))
    file.write([AUDIO_RATE].pack("V"))
    file.write([AUDIO_RATE * 2].pack("V"))
    file.write([1 * 2].pack("v"))
    file.write([16].pack("v"))
    file.write("data")
    file.write([data_size].pack("V"))

    wave_step = 0
    envelope = envelope_lead
    envelope_generator_level = 0
    lfo_wave = wave_lfo
    lfo_wave_step = 16

    NOTE_ON  = 0x80
    NOTE_OFF = 0x90

    note_number = 60
    count_per_wave_step = note_number_to_count[note_number]
    wave_rest = count_per_wave_step
    envelope_generator_state = A
    envelope_generator_rest = 0
    lfo_rest = (AUDIO_RATE * 1 / 2)
    lfo_wave_step = 0

    x_1, x_2, y_1, y_2 = 0, 0, 0, 0

#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 = 63,127, 63, 64,  127, 63 # cutoff_freq = 31500 /  2.01, Q = 0.7071
    b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 = 19, 37, 19, 64,    0, 11 # cutoff_freq = 31500 /  4,    Q = 0.7071
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  6, 12,  6, 64,  -60, 21 # cutoff_freq = 31500 /  8,    Q = 0.7071
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  2,  4,  2, 64,  -93, 37 # cutoff_freq = 31500 / 16,    Q = 0.7071
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  1,  2,  1, 64, -107, 46 # cutoff_freq = 31500 / 26.7,  Q = 0.7071
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  1,  2,  1, 64, -120, 59 # cutoff_freq = 31500 / 26.7,  Q = 2.8284

    prev = 0xFF
    pprev = 0xFF
    while(str = STDIN.read(1)) do
        c = str.ord

        if pprev == NOTE_ON && prev <= 0x7F && c <= 0x7F
            note_number = prev
            count_per_wave_step = note_number_to_count[note_number]
            wave_step = 0
            wave_rest = count_per_wave_step
            envelope_generator_state = A
            envelope_generator_rest = envelope[envelope_generator_state]
            lfo_rest = (AUDIO_RATE * 1 / 2)
            lfo_wave_step = 0
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
                lfo_rest = lfo_rest + (AUDIO_RATE / 32 / 4)
                lfo_wave_step += 1
                lfo_wave_step %= wave_num_steps
            end

            wave_rest -= 256
            while (wave_rest <= 0)
                wave_rest = wave_rest + count_per_wave_step * (lfo_wave[lfo_wave_step] - 8 + 1024) / 1024
                wave_step += 1
                wave_step %= wave_num_steps
                level = wave[wave_step] * envelope_generator_level / envelope_level_max
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

            if wave_rest < 256
                level = (wave[wave_step] * (wave_rest / 16) + wave[(wave_step + 1) % 32] * (16 - (wave_rest / 16))) * envelope_generator_level / 16
            else
                level = wave[wave_step] * envelope_generator_level
            end

            # filter
            x_0 = level
            y_0 = ((b0_a0 * x_0) + (b1_a0 * x_1) + (b2_a0 * x_2) - (a1_a0 * y_1) - (a2_a0 * y_2)) / 64;
            y_0 = 0 if y_0 < 0
            x_2 = x_1;
            x_1 = x_0;
            y_2 = y_1;
            y_1 = y_0;
#           file.write([level * 32].pack("S"))
            file.write([y_0 * 32].pack("S"))
        end
    end
end
