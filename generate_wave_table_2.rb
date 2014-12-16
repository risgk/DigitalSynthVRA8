require './common'

$file = File::open("WaveTable2.h", "w")

$file.printf("#pragma once\n\n")

def generate_wave_table(max, name)
  $file.printf("const uint8_t g_waveTable%sM%d[] PROGMEM = {\n  ", name, max)
  (0..255).each do |t|
    level = 0
    (1..max).each do |k|
      level += yield(t, k)
    end
    level = (level * 72).round.to_i
    $file.printf("%+4d,", level)

    if t == 255
      $file.printf("\n")
    elsif t % 16 == 15
      $file.printf("\n  ")
    else
      $file.printf(" ")
    end
  end
  $file.printf("};\n\n")
end

def generate_wave_table_pulse_25(max)
  generate_wave_table(max, "Pulse25") do |t, k|
    0.0
  end
end

def generate_wave_table_pulse_12(max)
  generate_wave_table(max, "Pulse12") do |t, k|
    0.0
  end
end

def generate_wave_table_pseudo_tri(max)
  generate_wave_table(max, "PseudoTri") do |t, k|
    0.0
  end
end

FREQ_MAX = 8819  # refs "FreqTable.h"

def max_from_i(i)
  max = 128 / (i + 1)
  max = 64 if max == 128
  max = max - 1 if max % 2 == 1
  return max
end

def generate_wave_tables(name)
  wave_table_sels = (0..(FREQ_MAX / 256))
  $file.printf("const uint8_t* g_waveTables%s[] = {\n", name)
  wave_table_sels.each do |i|
    $file.printf("  g_waveTable%sM%d,\n", name, max_from_i(i))
  end
  $file.printf("};\n\n")
end

overtones = (0..(FREQ_MAX / 256)).map { |i| max_from_i(i) }.uniq

overtones.each do |max|
  generate_wave_table_pulse_25(max)
end

overtones.each do |max|
  generate_wave_table_pulse_12(max)
end

overtones.each do |max|
  generate_wave_table_pseudo_tri(max)
end

generate_wave_tables("Pulse25")
generate_wave_tables("Pulse12")
generate_wave_tables("PseudoTri")

$file.close
