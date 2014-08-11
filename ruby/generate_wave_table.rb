def generate_wave_table(max, name)
  printf("$wave_table_%s_m%d = [\n  ", name, max)
  (0..255).each do |t|
    level = 0
    (1..max).each do |k|
      level += yield(t, k)
    end
    level = (level * 64).round.to_i
    printf("%+4d,", level)

    if t == 255
      printf("\n")
    elsif t % 16 == 15
      printf("\n  ")
    else
      printf(" ")
    end
  end
  printf("]\n\n")
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

def generate_wave_table_sine(max)
  generate_wave_table(max, "sine") do |t, k|
    if k == 1
      (Math::PI / 2) * Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k)
    else
      0
    end
  end
end

def generate_wave_table_list(name)
  wave_table_sels = (0..34)
  printf("$wave_table_%s = [\n", name)
  wave_table_sels.each do |i|
    max = 128 / (i + 1)
    if (name == "sine")
      max = 1
    end
    printf("  $wave_table_%s_m%d,\n", name, max)
  end
  printf("]\n\n")
end

overtones = [128, 64, 42, 32, 25, 21, 18, 16, 14, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3]

overtones.each do |max|
  generate_wave_table_saw(max)
end

overtones.each do |max|
  generate_wave_table_square(max)
end

[1].each do |max|
  generate_wave_table_sine(max)
end

generate_wave_table_list("saw")
generate_wave_table_list("square")
generate_wave_table_list("sine")

print <<EOS
$wave_tables = [
  $wave_table_saw,
  $wave_table_square,
  $wave_table_sine,
]
EOS
