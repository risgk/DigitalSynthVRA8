require './common'

$file = File::open("wave_table_2.rb", "w")

def generate_wave_table(max, name)
  $file.printf("$wave_table_%s_m%d = [\n  ", name, max)
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
  $file.printf("]\n\n")
end

def generate_wave_table_pulse_25(max)
  generate_wave_table(max, "pulse_25") do |t, k|
    0.0
  end
end

def generate_wave_table_pulse_12(max)
  generate_wave_table(max, "pulse_12") do |t, k|
    0.0
  end
end

def generate_wave_table_pseudo_tri(max)
  generate_wave_table(max, "pseudo_tri") do |t, k|
    0.0
  end
end

FREQ_MAX = 8819  # refs "freq_table.rb"

def max_from_i(i)
  max = 128 / (i + 1)
  max = 64 if max == 128
  max = max - 1 if max % 2 == 1
  return max
end

def generate_wave_tables(name)
  wave_table_sels = (0..(FREQ_MAX / 256))
  $file.printf("$wave_tables_%s = [\n", name)
  wave_table_sels.each do |i|
    $file.printf("  $wave_table_%s_m%d,\n", name, max_from_i(i))
  end
  $file.printf("]\n\n")
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

generate_wave_tables("pulse_25")
generate_wave_tables("pulse_12")
generate_wave_tables("pseudo_tri")

generate_wave_tables_sine

$file.close
