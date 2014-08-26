require './common'

$file = File::open("wave_table.rb", "wb")

def generate_wave_table(max, name)
  $file.printf("$wave_table_%s_m%d = [\n  ", name, max)
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
  $file.printf("]\n\n")
end

def generate_wave_table_sawtooth(max)
  generate_wave_table(max, "sawtooth") do |t, k|
    Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / k
  end
end

def generate_wave_table_square(max)
  generate_wave_table(max, "square") do |t, k|
    if k % 2 == 1
      2.0 * Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / k
    else
      0.0
    end
  end
end

def generate_wave_table_triangle(max)
  generate_wave_table(max, "triangle") do |t, k|
    if k % 4 == 1
      (4.0 / Math::PI) * Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / (k ** 2.0)
    elsif k % 4 == 3
      (4.0 / Math::PI) * -Math::sin((2.0 * Math::PI) * (t / 256.0) * k) / (k ** 2.0)
    else
      0.0
    end
  end
end

def generate_wave_table_sine
  generate_wave_table(1, "sine") do |t, k|
    if k == 1
      (Math::PI / 2.0) * Math::sin((2.0 * Math::PI) * (t / 256.0))
    else
      0.0
    end
  end
end

FREQ_MAX = 4409  # refs "freq_table.rb"

def generate_wave_tables(name, sine = false)
  wave_table_sels = (0..(FREQ_MAX / 256))
  $file.printf("$wave_tables_%s = [\n", name)
  wave_table_sels.each do |i|
    if sine 
      max = 1
    elsif
      max = 128 / (i + 1)
      max = 64 if max == 128
    end
    $file.printf("  $wave_table_%s_m%d,\n", name, max)
  end
  $file.printf("]\n\n")
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

generate_wave_table_sine

generate_wave_tables("sawtooth")
generate_wave_tables("square")
generate_wave_tables("triangle")
generate_wave_tables("sine", true)

$file.close
