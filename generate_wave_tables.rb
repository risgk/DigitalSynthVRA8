def generate_wave_table(max, name)
  printf("$wave_table_%s_m%d = [\n  ", name, max)
  (0..255).each do |t|
    level = 0
    (1..max).each do |k|
      level += yield(t, k)
    end
    level = ((level + 2) * 64).to_i
      printf("0x%02X,", level)
    if t % 256 == 255
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
    ((-1 ** k) * Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / k)
  end
end

def generate_wave_table_square(max)
  generate_wave_table(max, "square") do |t, k|
    if k % 2 == 1
      2.0 * (Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / k)
    else
      0
    end
  end
end

def generate_wave_table_triangle(max)
  generate_wave_table(max, "triangle") do |t, k|
    if k % 4 == 1
      (4 / Math::PI) * (Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / +(k ** 2))
    elsif k % 4 == 3
      (4 / Math::PI) * (Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / -(k ** 2))
    else
      0
    end
  end
end

def generate_wave_table_sine(max)
  generate_wave_table(max, "sine") do |t, k|
    if k == 1
      (Math::PI / 2) * (Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k))
    else
      0
    end
  end
end

[128, 64, 32, 16, 8].each do |max|
  generate_wave_table_saw(max)
end

[128, 64, 32, 16, 8].each do |max|
  generate_wave_table_square(max)
end

[128, 64, 32, 16, 8].each do |max|
  generate_wave_table_triangle(max)
end

[128, 64, 32, 16, 8].each do |max|
  generate_wave_table_sine(max)
end

print <<EOS
$wave_table_saw = [
  $wave_table_saw_m128,
  $wave_table_saw_m64,
  $wave_table_saw_m32,
  $wave_table_saw_m32,
  $wave_table_saw_m16,
  $wave_table_saw_m16,
  $wave_table_saw_m16,
  $wave_table_saw_m16,
  $wave_table_saw_m8,
]

$wave_table_square = [
  $wave_table_square_m128,
  $wave_table_square_m64,
  $wave_table_square_m32,
  $wave_table_square_m32,
  $wave_table_square_m16,
  $wave_table_square_m16,
  $wave_table_square_m16,
  $wave_table_square_m16,
  $wave_table_square_m8,
]

$wave_table_triangle = [
  $wave_table_triangle_m128,
  $wave_table_triangle_m64,
  $wave_table_triangle_m32,
  $wave_table_triangle_m32,
  $wave_table_triangle_m16,
  $wave_table_triangle_m16,
  $wave_table_triangle_m16,
  $wave_table_triangle_m16,
  $wave_table_triangle_m8,
]

$wave_table_sine = [
  $wave_table_sine_m128,
  $wave_table_sine_m64,
  $wave_table_sine_m32,
  $wave_table_sine_m32,
  $wave_table_sine_m16,
  $wave_table_sine_m16,
  $wave_table_sine_m16,
  $wave_table_sine_m16,
  $wave_table_sine_m8,
]

$wave_tables = [
  $wave_table_saw,
  $wave_table_square,
  $wave_table_triangle,
  $wave_table_sine,
]
EOS
