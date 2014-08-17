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

def generate_wave_table_saw(max)
  generate_wave_table(max, "saw") do |t, k|
    Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / k
  end
end

def generate_wave_table_square(max)
  generate_wave_table(max, "square") do |t, k|
    if k % 2 == 1
      2.0 * Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / k
    else
      0
    end
  end
end

def generate_wave_table_triangle(max)
  generate_wave_table(max, "triangle") do |t, k|
    if k % 4 == 1
      (4.0 / Math::PI) * (Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / +(k ** 2))
    elsif k % 4 == 3
      (4.0 / Math::PI) * (Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / -(k ** 2))
    else
      0
    end
  end
end

def generate_wave_tables(name)
  wave_table_sels = (0..34)
  $file.printf("$wave_tables_%s = [\n", name)
  wave_table_sels.each do |i|
    max = 128 / (i + 1)
    $file.printf("  $wave_table_%s_m%d,\n", name, max)
  end
  $file.printf("]\n\n")
end

overtones = [128, 64, 42, 32, 25, 21, 18, 16, 14, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3]

overtones.each do |max|
  generate_wave_table_saw(max)
end

overtones.each do |max|
  generate_wave_table_square(max)
end

overtones.each do |max|
  generate_wave_table_triangle(max)
end

generate_wave_tables("saw")
generate_wave_tables("square")
generate_wave_tables("triangle")

$file.print <<EOS
$wave_tables = [
  $wave_tables_saw,
  $wave_tables_square,
  $wave_tables_triangle,
]
EOS

$file.close
