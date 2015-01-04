require './common'

$file = File::open("wave_table.rb", "w")

def generate_wave_table(max, name, amp)
  $file.printf("$wave_table_%s_m%d = [\n  ", name, max)
  (0..255).each do |n|
    level = 0
    (1..max).each do |k|
      level += amp * yield(n, k)
    end
    level = (level * 80).round.to_i
    $file.printf("%+4d,", level)

    if n == 255
      $file.printf("\n")
    elsif n % 16 == 15
      $file.printf("\n  ")
    else
      $file.printf(" ")
    end
  end
  $file.printf("]\n\n")
end

def generate_wave_table_sawtooth(max)
  generate_wave_table(max, "sawtooth", 1.0) do |n, k|
    (2.0 / Math::PI) * Math::sin((2.0 * Math::PI) * ((n + 0.5) / 256.0) * k) / k
  end
end

def generate_wave_table_square(max)
  generate_wave_table(max, "square", 1.0 / Math::sqrt(3.0)) do |n, k|
    if k % 2 == 1
      (4.0 / Math::PI) * Math::sin((2.0 * Math::PI) * ((n + 0.5) / 256.0) * k) / k
    else
      0.0
    end
  end
end

def generate_wave_table_triangle(max)
  generate_wave_table(max, "triangle", 1.0) do |n, k|
    if k % 4 == 1
      (8.0 / (Math::PI ** 2)) * Math::sin((2.0 * Math::PI) * ((n + 0.5) / 256.0) * k) / (k ** 2.0)
    elsif k % 4 == 3
      (8.0 / (Math::PI ** 2)) * -Math::sin((2.0 * Math::PI) * ((n + 0.5) / 256.0) * k) / (k ** 2.0)
    else
      0.0
    end
  end
end

def generate_wave_table_sine(max)
  generate_wave_table(max, "sine", Math::sqrt(2.0) / Math::sqrt(3.0)) do |n, k|
    if k == 1
      Math::sin((2.0 * Math::PI) * ((n + 0.5) / 256.0) * k)
    else
      0.0
    end
  end
end

FREQ_MAX = 8819  # refs "freq_table.rb"

def max_from_i(i)
  max = 128 / (i + 1)
  max = 64 if max == 128
  max = max - 1 if max % 2 == 0
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

def generate_wave_tables_sine
  name = "sine"
  wave_table_sels = (0..(FREQ_MAX / 256))
  $file.printf("$wave_tables_%s = [\n", name)
  wave_table_sels.each do |i|
    $file.printf("  $wave_table_%s_m%d,\n", name, 1)
  end
  $file.printf("]\n\n")
end

overtones = (0..(FREQ_MAX / 256)).map { |i| max_from_i(i) }.uniq

overtones.each do |max|
  generate_wave_table_sawtooth(max)
end

overtones.each do |max|
  generate_wave_table_square(max)
end

overtones.each do |max|
  generate_wave_table_triangle(max)
end

generate_wave_table_sine(1)

generate_wave_tables("sawtooth")
generate_wave_tables("square")
generate_wave_tables("triangle")
generate_wave_tables_sine

$file.close
