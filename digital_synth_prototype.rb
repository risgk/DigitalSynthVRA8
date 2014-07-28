require './wave_tables'
require './other_tables'

PWM_RATE = 62500
AUDIO_RATE = 31250

WAVE_SAW        = 0x00
WAVE_SQUARE     = 0x01
WAVE_TRIANGLE   = 0x02
WAVE_PULSE_1_4  = 0x03
WAVE_PULSE_1_8  = 0x04

def high_byte(us)
  us >> 8
end

def low_byte(us)
  us & 0xFF
end

class OSC
  def initialize
    @wave_table = $wave_tables[WAVE_SAW]
    @freq = $note_number_to_freq[60]
    @phase = 0
  end

  def set_wave(wave)
    @wave_table = $wave_tables[wave]
  end

  def set_note(note_number)
    @freq = $note_number_to_freq[note_number]
  end

  def reset
    @phase = 0
  end

  def clock
    @phase += @freq
    @phase &= 0xFFFF
    curr_index = high_byte(@phase)
    next_index = curr_index + 1
    next_index &= 0xFF
    next_weight = low_byte(@phase)
    curr_weight = 0x100 - next_weight
    table_id = @freq >> 8
    if table_id > 8
      table_id = 8
    end
    level = high_byte(@wave_table[table_id][curr_index] * curr_weight + @wave_table[table_id][next_index] * next_weight)
    return level
  end
end

osc = [OSC.new, OSC.new, OSC.new]
osc[0].set_wave(WAVE_PULSE_1_8)
osc[1].set_wave(WAVE_SQUARE)
osc[2].set_wave(WAVE_TRIANGLE)

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

class LPF
  attr_accessor :x_0, :x_1, :x_2, :y_0, :y_1, :y_2
  attr_accessor :b0_a0, :b1_a0, :b2_a0, :a1_a0, :a2_a0
end

lpf = LPF.new

lpf.x_0, lpf.x_1, lpf.x_2, lpf.y_0, lpf.y_1, lpf.y_2 = 0, 0, 0, 0, 0, 0

  lpf.b0_a0, lpf.b1_a0, lpf.b2_a0, lpf.a1_a0, lpf.a2_a0 = 19, 37, 19,   0, 11 # f_cutoff = AUDIO_RATE /  4, Q = 0.7071
# lpf.b0_a0, lpf.b1_a0, lpf.b2_a0, lpf.a1_a0, lpf.a2_a0 =  6, 12,  6, -60, 21 # f_cutoff = AUDIO_RATE /  8, Q = 0.7071
# lpf.b0_a0, lpf.b1_a0, lpf.b2_a0, lpf.a1_a0, lpf.a2_a0 =  2,  4,  2, -93, 37 # f_cutoff = AUDIO_RATE / 16, Q = 0.7071

midi_in_prev = 0xFF
midi_in_pprev = 0xFF

STDIN.binmode
File::open("a.wav","w+b") do |file|
  data_size = 2 * AUDIO_RATE * 25
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

  while(c = STDIN.read(1)) do
    b = c.ord

    if (midi_in_pprev == NOTE_ON && midi_in_prev <= 0x7F && b <= 0x7F)
      note_number = midi_in_prev
      osc[0].set_note(note_number)
#     osc[0].reset
      eg_state = A
      eg_level = 0
      eg_rest = envelope[eg_state]
    end
    if (midi_in_pprev == NOTE_OFF && midi_in_prev <= 0x7F && b <= 0x7F)
      eg_state = R
      eg_rest = envelope[eg_state]
    end
    midi_in_pprev = midi_in_prev
    midi_in_prev = b

    for i in (0...10) do

      # OSC
      level = osc[0].clock

      # EG
      eg_rest -= 1
      case (eg_state)
      when A
        if eg_rest <= 0
          if eg_level < envelope_level_max
            eg_level += 1
            eg_rest = envelope[eg_state]
          else
            eg_state = D
            eg_rest = envelope[eg_state]
          end
        end
      when D
        if eg_rest <= 0
          if eg_level > envelope[2]
            eg_level -= 1
            eg_rest = envelope[eg_state]
          else
            eg_state = S
            eg_rest = 9999
          end
        end
      when S
      when R
        if eg_rest <= 0
          if eg_level > 0
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

      # MIXER
      level = level

      # LPF
      lpf.x_0 = level
      lpf.y_0 = ((lpf.b0_a0 * lpf.x_0) + (lpf.b1_a0 * lpf.x_1) + (lpf.b2_a0 * lpf.x_2) - (lpf.a1_a0 * lpf.y_1) - (lpf.a2_a0 * lpf.y_2)) / 64;
      if (lpf.y_0 < 0)
        lpf.y_0 = 0
      end
      lpf.x_2 = lpf.x_1;
      lpf.x_1 = lpf.x_0;
      lpf.y_2 = lpf.y_1;
      lpf.y_1 = lpf.y_0;

      # PWM
      file.write([(level - 128)* 32].pack("S"))
#     file.write([(lpf.y_0 - 128) * 32].pack("S"))
    end
  end
end
