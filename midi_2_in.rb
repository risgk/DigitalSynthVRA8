SAMPLE_RATE = 31250

wavemem_num_steps = 32
wavemem_free1 = [
    0x3, 0x4, 0x4, 0x3, 0x3, 0x4, 0x5, 0x5, 0x6, 0x6, 0x7, 0x6, 0x4, 0x2, 0x1, 0xB,
    0xB, 0xA, 0x8, 0x8, 0x9, 0xB, 0xE, 0xF, 0x4, 0x5, 0x4, 0x3, 0x3, 0x2, 0x1, 0x0, 
]
wavemem_triangle = [
    0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
    0xF, 0xE, 0xD, 0xC, 0xB, 0xA, 0x9, 0x8, 0x7, 0x6, 0x5, 0x4, 0x3, 0x2, 0x1, 0x0
]
wavemem_saw = [
    0x0, 0x0, 0x1, 0x1, 0x2, 0x2, 0x3, 0x3, 0x4, 0x4, 0x5, 0x5, 0x6, 0x6, 0x7, 0x7,
    0x8, 0x8, 0x9, 0x9, 0xA, 0xA, 0xB, 0xB, 0xC, 0xC, 0xD, 0xD, 0xE, 0xE, 0xF, 0xF
]
wavemem_square = [
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF
]
wavemem_square4 = [
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0xF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
]
wavemem_square8 = [
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0xF, 0xF, 0xF, 0xF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
]
wavemem_lfo = [
    0x8, 0x9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0xF, 0xE, 0xD, 0xC, 0xB, 0xA, 0x9, 0x8,
    0x7, 0x6, 0x5, 0x4, 0x3, 0x2, 0x1, 0x0, 0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7
]

note_number_to_count = [
    0x7772, 0x70BD, 0x6A69, 0x6470, 0x5ECD, 0x597B, 0x5475, 0x4FB8,
    0x4B3E, 0x4705, 0x4309, 0x3F46, 0x3BB9, 0x385E, 0x3534, 0x3238,
    0x2F66, 0x2CBD, 0x2A3A, 0x27DC, 0x259F, 0x2382, 0x2184, 0x1FA3,
    0x1DDC, 0x1C2F, 0x1A9A, 0x191C, 0x17B3, 0x165E, 0x151D, 0x13EE,
    0x12CF, 0x11C1, 0x10C2, 0x0FD1, 0x0EEE, 0x0E17, 0x0D4D, 0x0C8E,
    0x0BD9, 0x0B2F, 0x0A8E, 0x09F7, 0x0967, 0x08E0, 0x0861, 0x07E8,
    0x0777, 0x070B, 0x06A6, 0x0647, 0x05EC, 0x0597, 0x0547, 0x04FB,
    0x04B3, 0x0470, 0x0430, 0x03F4, 0x03BB, 0x0385, 0x0353, 0x0323,
    0x02F6, 0x02CB, 0x02A3, 0x027D, 0x0259, 0x0238, 0x0218, 0x01FA,
    0x01DD, 0x01C2, 0x01A9, 0x0191, 0x017B, 0x0165, 0x0151, 0x013E,
    0x012C, 0x011C, 0x010C, 0x00FD, 0x00EE, 0x00E1, 0x00D4, 0x00C8,
    0x00BD, 0x00B2, 0x00A8, 0x009F, 0x0096, 0x008E, 0x0086, 0x007E,
    0x0077, 0x0070, 0x006A, 0x0064, 0x005E, 0x0059, 0x0054, 0x004F,
    0x004B, 0x0047, 0x0043, 0x003F, 0x003B, 0x0038, 0x0035, 0x0032,
    0x002F, 0x002C, 0x002A, 0x0027, 0x0025, 0x0023, 0x0021, 0x001F,
    0x001D, 0x001C, 0x001A, 0x0019, 0x0017, 0x0016, 0x0015, 0x0013,
]

envelope_lead = [0,500,16,0]
envelope_level_max = 16
A = 0
D = 1
S = 2
R = 3

STDIN.binmode
File::open(__FILE__ + ".wav","w+b") do |file|
    data_size = 2 * SAMPLE_RATE * 9
    file_size = data_size + 36
    file.write("RIFF")
    file.write([file_size - 8].pack("V"))
    file.write("WAVE")
    file.write("fmt ")
    file.write([16].pack("V"))
    file.write([1].pack("v"))
    file.write([1].pack("v"))
    file.write([SAMPLE_RATE].pack("V"))
    file.write([SAMPLE_RATE * 2].pack("V"))
    file.write([1 * 2].pack("v"))
    file.write([16].pack("v"))
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
    count_per_wavemem_step = note_number_to_count[note_number]
    wavemem_rest = count_per_wavemem_step
    envelope_generator_state = A
    envelope_generator_rest = 0
    lfo_rest = (SAMPLE_RATE * 1 / 2)
    lfo_wavemem_step = 0

    x_1, x_2, y_1, y_2 = 0, 0, 0, 0
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 = 19, 37, 19, 64,    0, 11 # f0 = 31500 /  4,   Q = 0.7071
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  6, 12,  6, 64,  -60, 21 # f0 = 31500 /  8,   Q = 0.7071
    b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  2,  4,  2, 64,  -93, 37 # f0 = 31500 / 16,   Q = 0.7071
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  1,  2,  1, 64, -107, 46 # f0 = 31500 / 26.7, Q = 0.7071
#   b0_a0, b1_a0, b2_a0, a0_a0, a1_a0, a2_a0 =  1,  2,  1, 64, -120, 59 # f0 = 31500 / 26.7, Q = 2.8284

    prev = 0xFF
    pprev = 0xFF
    while(str = STDIN.read(1)) do
        c = str.ord

        if pprev == NOTE_ON && prev <= 0x7F && c <= 0x7F
            note_number = prev
            count_per_wavemem_step = note_number_to_count[note_number]
            wavemem_step = 0
            wavemem_rest = count_per_wavemem_step
            envelope_generator_state = A
            envelope_generator_rest = envelope[envelope_generator_state]
            lfo_rest = (SAMPLE_RATE * 1 / 2)
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
                lfo_rest = lfo_rest + (SAMPLE_RATE / 32 / 4)
                lfo_wavemem_step += 1
                lfo_wavemem_step %= wavemem_num_steps
            end

            wavemem_rest -= 256
            while (wavemem_rest <= 0)
                wavemem_rest = wavemem_rest + count_per_wavemem_step * (lfo_wavemem[lfo_wavemem_step] - 8 + 1024) / 1024.0
                wavemem_step += 1
                wavemem_step %= wavemem_num_steps
                level = wavemem[wavemem_step] * envelope_generator_level / envelope_level_max
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

            if wavemem_rest < 256
                level = ((wavemem[wavemem_step] * wavemem_rest / 256.0 +
                          wavemem[(wavemem_step + 1) % 32] * (256 - wavemem_rest) / 256.0) *
                         envelope_generator_level).to_i
            else
                level = wavemem[wavemem_step] * envelope_generator_level
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