require './common'
require './freq_table'
require './wave_table'

class Oscillator
  WAVEFORM_SAW = 0x00
  WAVEFORM_SQUARE = 0x01
  WAVEFORM_SINE = 0x02

  def initialize
    @wave_tables = $wave_tables[WAVEFORM_SAW]
    @phase = 0x0000
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
    @note_number = note_number
    update_freq
  end

  def note_off
    # do noshing
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
    if (pitch >= 0x40 && pitch <= 0xBF)
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
