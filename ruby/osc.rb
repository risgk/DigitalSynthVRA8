require './common'
require './freq_table'
require './wave_table'

class Osc
  SAW = 0; SQUARE = 1; TRIANGLE = 2

  def initialize
    @wave_tables = $wave_tables[SAW]
    @phase = 0
    @note_number = 0
    @coarse_tune = 64
    @fine_tune = 64
    @freq = 0
  end

  def set_waveform(waveform)
    case waveform
    when SAW, SQUARE, TRIANGLE
      @wave_tables = $wave_tables[waveform]
    else
      @wave_tables = $wave_tables[SAW]
    end
  end

  def note_on(note_number)
    @phase = 0
    @note_number = note_number
    update_freq
  end

  def note_off
    # do nothing
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
    if (@fine_tune < 64)
      freq_table_sel = 0
    elsif (@fine_tune == 64)
      freq_table_sel = 1
    else
      freq_table_sel = 2
    end

    pitch = @note_number + @coarse_tune
    if (pitch >= (NOTE_NUMBER_MIN + 64) && pitch <= (NOTE_NUMBER_MAX + 64))
      @freq = $freq_tables[freq_table_sel][pitch - 64]
    else
      @freq = 0
    end
  end

  def clock
    @phase += @freq
    @phase &= 0xFFFF

    wave_table_sel = high_byte(@freq)
    wave_table = @wave_tables[wave_table_sel]

    curr_index = high_byte(@phase)
    next_index = curr_index + 0x01
    next_index &= 0xFF
    curr_data = wave_table[curr_index]
    next_data = wave_table[next_index]

    next_weight = low_byte(@phase)
    if (next_weight == 0)
      level = curr_data
    else
      curr_weight = 0x100 - next_weight
      level = high_byte((curr_data * curr_weight) + (next_data * next_weight))
    end

    return level
  end
end
