require './common'

$file = File::open("waveTable.h", "w")

$file.printf("#pragma once\n\n")

def generate_wave_table(max, name)
  $file.printf("const uint8_t g_waveTable%sM%d[] PROGMEM = {\n  ", name, max)
  (0..255).each do |t|
    level = 0
    (1..max).each do |k|
      level += yield(t, k)
    end
    level = (level * 64).round.to_i
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

def generate_wave_table_sawtooth(max)
  generate_wave_table(max, "Sawtooth") do |t, k|
    Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / k
  end
end

def generate_wave_table_square(max)
  generate_wave_table(max, "Square") do |t, k|
    if k % 2 == 1
      2.0 * Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / k
    else
      0.0
    end
  end
end

def generate_wave_table_triangle(max)
  generate_wave_table(max, "Triangle") do |t, k|
    if k % 4 == 1
      (4.0 / Math::PI) * Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / (k ** 2.0)
    elsif k % 4 == 3
      (4.0 / Math::PI) * -Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / (k ** 2.0)
    else
      0.0
    end
  end
end

FREQ_MAX = 8819  # refs "FreqTable.h"

def generate_wave_tables(name)
  wave_table_sels = (0..(FREQ_MAX / 256))
  $file.printf("const uint8_t* g_waveTables%s[] = {\n", name)
  wave_table_sels.each do |i|
    max = 128 / (i + 1)
    max = 64 if max == 128
    $file.printf("  g_waveTable%sM%d,\n", name, max)
  end
  $file.printf("};\n\n")
end

overtones = (0..(FREQ_MAX / 256)).map { |i| 128 / (i + 1) }.map { |i| i == 128 ? 64 : i }.uniq

overtones.each do |max|
  generate_wave_table_sawtooth(max)
end

overtones.each do |max|
  generate_wave_table_square(max)
end

overtones.each do |max|
  generate_wave_table_triangle(max)
end

generate_wave_tables("Sawtooth")
generate_wave_tables("Square")
generate_wave_tables("Triangle")

$file.close
