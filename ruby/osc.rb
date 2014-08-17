require './common'
require './freq_table'
require './wave_table'

class Osc
  def initialize
    @wave_tables = $wave_tables_saw
    @coarse_tune = 64
    @fine_tune = 64
    @note_number = 60
    @phase = 0
    @freq = 0
  end

  def set_waveform(waveform)
    case waveform
    when WAVEFORM_SAW
      @wave_tables = $wave_tables_saw
    when WAVEFORM_SQUARE
      @wave_tables = $wave_tables_square
    when WAVEFORM_TRIANGLE
      @wave_tables = $wave_tables_triangle
    end
  end

  def set_coarse_tune(coarse_tune)
    @coarse_tune = coarse_tune
    update_freq
  end

  def set_fine_tune(fine_tune)
    @fine_tune = fine_tune
    update_freq
  end

  def note_on(note_number)
    @phase = 0
    @note_number = note_number
    update_freq
  end

  def note_off
    # do nothing
  end

  def clock
    @phase += @freq
    @phase &= 0xFFFF

    wave_table = @wave_tables[high_byte(@freq)]
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

  private
  def update_freq
    pitch = @note_number + @coarse_tune
    if (pitch < (NOTE_NUMBER_MIN + 64) || pitch > (NOTE_NUMBER_MAX + 64))
      @freq = 0
    else
      note_number = pitch - 64
      if (@fine_tune < 64)
        @freq = $freq_table_minus_10_cent[note_number]
      elsif (@fine_tune == 64)
        @freq = $freq_table_0_cent[note_number]
      else
        @freq = $freq_table_plus_10_cent[note_number]
      end
    end
  end
end
