require './freq_tables_'
require './wave_tables_'

AUDIO_RATE = 31250; PWM_RATE = 31250
WAVEFORM_SAW = 0x00; WAVEFORM_SQUARE = 0x01; WAVEFORM_SINE = 0x02

def high_byte(us)
  return (us >> 8)
end

def low_byte(us)
  return (us & 0xFF)
end

class OSC
  def initialize
    @wave_tables = $wave_tables[WAVEFORM_SAW]
    @phase = 0x0000
    @note_on = false
    @note_number = 0x00
    @coarse_tune = 0x40
    @fine_tune = 0x40
    @freq = 0x0000
    @volume = 0x7F
  end

  def set_waveform(waveform)
    @wave_tables = $wave_tables[waveform]
  end

  def note_on(note_number)
    @phase = 0x0000
    @note_on = true
    @note_number = note_number
    update_freq
  end

  def note_off()
    @phase = 0x0000
    @note_on = false
    update_freq
  end

  def set_coarse_tune(coarse_tune)
    @coarse_tune = coarse_tune
    update_freq
  end

  def set_fine_tune(fine_tune)
    @fine_tune = fine_tune
    update_freq
  end

  def update_freq
    note_on = @note_on
    note_number = @note_number
    coarse_tune = @coarse_tune
    fine_tune = @fine_tune

    if (fine_tune < 0x40)
      freq_table_sel = 0x00
    elsif (fine_tune == 0x40)
      freq_table_sel = 0x01
    else
      freq_table_sel = 0x02
    end

    pitch = note_number + coarse_tune
    if (note_on && pitch >= 0x40 && pitch <= 0xBF)
      @freq = $freq_tables[freq_table_sel][pitch - 0x40]
    else
      @freq = 0
    end
  end

  def set_volume(volume)
    @volume = volume
  end

  def clock
    freq = @freq
    phase = @phase
    phase += freq
    phase &= 0xFFFF
    @phase = phase

    wave_table_sel = high_byte(freq)
    if ((wave_table_sel & 0xF0) != 0)
      wave_table_sel = 0x10
    end
    wave_table = @wave_tables[wave_table_sel]

    curr_index = high_byte(phase)
    next_index = curr_index + 0x01
    next_index &= 0xFF
    curr_data = wave_table[curr_index]
    next_data = wave_table[next_index]

    next_weight = low_byte(phase) >> 1
    curr_weight = 0x80 - next_weight
    level_15 = (curr_data * curr_weight) + (next_data * next_weight)
    level = ((high_byte(level_15) << 1) & 0xFF) + ((low_byte(level_15) >> 7) & 0xFF)

    reduction = 0x03 - (@volume >> 5)
    if (reduction == 0x03)
      level = 0x80
    else
      level = (level >> reduction) + 0x80 - (0x80 >> reduction)
    end

    return level
  end
end

class MIX
  def clock(a, b, c, d)
    level_10 = a + b + c + d
    level = ((high_byte(level_10) << 6) & 0xFF) + ((low_byte(level_10) >> 2) & 0xFF)
    return level
  end
end

class LPF
  def initialize
    @x_0, @x_1, @x_2 = 0, 0, 0
    @y_0, @y_1, @y_2 = 0, 0, 0
    @b1_a0, @b2_a0, @a1_a0, @a2_a0 = 37, 19,   0, 11 # cutoff = AUDIO_RATE /  4, Q = 0.7071
#   @b1_a0, @b2_a0, @a1_a0, @a2_a0 = 12,  6, -60, 21 # cutoff = AUDIO_RATE /  8, Q = 0.7071
#   @b1_a0, @b2_a0, @a1_a0, @a2_a0 =  4,  2, -93, 37 # cutoff = AUDIO_RATE / 16, Q = 0.7071
  end

  def clock(input)
    @x_0 = input
    @y_0 = ((@b2_a0 * @x_0) + (@b1_a0 * @x_1) + (@b2_a0 * @x_2) - (@a1_a0 * @y_1) - (@a2_a0 * @y_2)) / 64;
    if (@y_0 < 0)
      @y_0 = 0
    end
    @x_2 = @x_1;
    @x_1 = @x_0;
    @y_2 = @y_1;
    @y_1 = @y_0;
    return @y_0
  end
end

osc1 = OSC.new
osc2 = OSC.new
osc3 = OSC.new
mix = MIX.new
lpf = LPF.new

osc1.set_waveform(WAVEFORM_SQUARE)
osc2.set_waveform(WAVEFORM_SAW)
osc3.set_waveform(WAVEFORM_SAW)
osc1.set_fine_tune(0x4A)
osc2.set_fine_tune(0x36)

envelope_lead = [0,40,256,0]
envelope_level_max = 256
A = 0
D = 1
S = 2
R = 3

envelope = envelope_lead
eg_level = 0

NOTE_ON  = 0x80
NOTE_OFF = 0x90

eg_state = A
eg_rest = 0

midi_in_prev = 0xFF
midi_in_pprev = 0xFF

STDIN.binmode
File::open("a.wav","w+b") do |file|
  data_size = AUDIO_RATE * 2 * 30
  file_size = data_size + 36
  file.write("RIFF"); file.write([file_size - 8].pack("V")); file.write("WAVE"); file.write("fmt ")
  file.write([16].pack("V")); file.write([1, 1].pack("v*")); file.write([AUDIO_RATE, AUDIO_RATE * 2].pack("V*"))
  file.write([2, 16].pack("v*")); file.write("data"); file.write([data_size].pack("V"))

  while(c = STDIN.read(1)) do
    b = c.ord

    if (midi_in_pprev == NOTE_ON && midi_in_prev <= 0x7F && b <= 0x7F)
      note_number = midi_in_prev
      osc1.note_on(note_number)
      osc2.note_on(note_number)
      osc3.note_on(note_number)
      eg_state = A
      eg_level = 0
      eg_rest = envelope[eg_state]
    end
    if (midi_in_pprev == NOTE_OFF && midi_in_prev <= 0x7F && b <= 0x7F)
      osc1.note_off()
      osc2.note_off()
      osc3.note_off()
      eg_state = R
      eg_rest = envelope[eg_state]
    end
    midi_in_pprev = midi_in_prev
    midi_in_prev = b

    for i in (0...10) do
      level = mix.clock(osc1.clock, osc2.clock, osc3.clock, 0x80)

      # ENV
      eg_rest -= 1
      case (eg_state)
      when A
        if (eg_rest <= 0)
          if (eg_level < envelope_level_max)
            eg_level += 1
            eg_rest = envelope[eg_state]
          else
            eg_state = D
            eg_rest = envelope[eg_state]
          end
        end
      when D
        if (eg_rest <= 0)
          if (eg_level > envelope[2])
            eg_level -= 1
            eg_rest = envelope[eg_state]
          else
            eg_state = S
            eg_rest = 9999
          end
        end
      when S
      when R
        if (eg_rest <= 0)
          if (eg_level > 0)
            eg_level -= 1
            eg_rest = envelope[eg_state]
          else
            eg_level = 0
            eg_rest = 9999
          end
        end
      end

      # AMP
      level = level

      # LPF
      level = lpf.clock(level)

      # PWM
      file.write([(level - 128) * 64].pack("S"))
    end
  end
end
