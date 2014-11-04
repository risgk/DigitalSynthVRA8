require './common'

$file = File::open("FreqTable.h", "w")

$file.printf("#pragma once\n\n")

$c4_to_b4 = []
(0..11).each do |i|
  note_number = i + 60
  cent = (note_number * 100.0) - 6900.0
  hz = 440.0 * (2.0 ** (cent / 1200.0))
  freq = ((hz * 256.0 * 256.0 / SAMPLING_RATE) / 8.0).round * 8
  $c4_to_b4[i] = freq
end

def generate_freq_table(detune, name)
  $file.printf("const uint16_t g_freqTable%s[] PROGMEM = {\n  ", name)
  (0..127).each do |note_number|
    if note_number < NOTE_NUMBER_MIN || note_number > NOTE_NUMBER_MAX
      freq = 0
    else
      base = ($c4_to_b4[note_number % 12] * (2 ** (note_number / 12 - 5))).to_i
      delta_abs = ((base * (2.0 ** (detune.abs / 1200.0))).round - base).to_i
      delta_abs = 1 if (detune != 0 && delta_abs == 0)
      freq = (detune >= 0.0) ? (base + delta_abs) : (base - delta_abs)
    end

    $file.printf("%5d,", freq)
    if note_number == 127
      $file.printf("\n")
    elsif note_number % 12 == 11
      $file.printf("\n  ")
    else
      $file.printf(" ")
    end
  end
  $file.printf("};\n\n")
end

generate_freq_table(-9.375, "DetuneMinus")
generate_freq_table(0.0, "DetuneNone")
generate_freq_table(9.375, "DetunePlus")

$file.close
