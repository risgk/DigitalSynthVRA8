def generate_wave_table(max, name)
  printf("$wave_table_%s_m%d = [\n  ", name, max)
  (0..255).each do |t|
    level = 0
    (1..max).each do |k|
      level += yield(t, k)
    end
    level = ((level + 2) * 64).to_i
    printf("0x%02X,", level)

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

overtones = [128, 64, 42, 32, 25, 21, 18, 16, 14, 12, 11, 10, 9, 8, 7]

overtones.each do |max|
  generate_wave_table_saw(max)
end

overtones.each do |max|
  generate_wave_table_square(max)
end

overtones.each do |max|
  generate_wave_table_sine(max)
end

print <<EOS
$wave_table_saw = [
  $wave_table_saw_m128,
  $wave_table_saw_m64,
  $wave_table_saw_m42,
  $wave_table_saw_m32,
  $wave_table_saw_m25,
  $wave_table_saw_m21,
  $wave_table_saw_m18,
  $wave_table_saw_m16,
  $wave_table_saw_m14,
  $wave_table_saw_m12,
  $wave_table_saw_m11,
  $wave_table_saw_m10,
  $wave_table_saw_m9,
  $wave_table_saw_m9,
  $wave_table_saw_m8,
  $wave_table_saw_m8,
  $wave_table_saw_m7,
]

$wave_table_square = [
  $wave_table_square_m128,
  $wave_table_square_m64,
  $wave_table_square_m42,
  $wave_table_square_m32,
  $wave_table_square_m25,
  $wave_table_square_m21,
  $wave_table_square_m18,
  $wave_table_square_m16,
  $wave_table_square_m14,
  $wave_table_square_m12,
  $wave_table_square_m11,
  $wave_table_square_m10,
  $wave_table_square_m9,
  $wave_table_square_m9,
  $wave_table_square_m8,
  $wave_table_square_m8,
  $wave_table_square_m7,
]

$wave_table_sine = [
  $wave_table_sine_m128,
  $wave_table_sine_m64,
  $wave_table_sine_m42,
  $wave_table_sine_m32,
  $wave_table_sine_m25,
  $wave_table_sine_m21,
  $wave_table_sine_m18,
  $wave_table_sine_m16,
  $wave_table_sine_m14,
  $wave_table_sine_m12,
  $wave_table_sine_m11,
  $wave_table_sine_m10,
  $wave_table_sine_m9,
  $wave_table_sine_m9,
  $wave_table_sine_m8,
  $wave_table_sine_m8,
  $wave_table_sine_m7,
]

$wave_tables = [
  $wave_table_saw,
  $wave_table_square,
  $wave_table_sine,
]
EOS
