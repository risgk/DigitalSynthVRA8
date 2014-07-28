def generate_wave_table(max, name, pulse_duty = nil)
  printf("$wave_table_%s_m%d = [\n  ", name, max)
  (0..255).each do |t|
    level = 0
    (1..max).each do |k|
      level += yield(t, k)
    end
    if pulse_duty
      level -= (pulse_duty * Math::PI * 1.5)
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
    (Math::sin(((2.0 * Math::PI) * (t / 256.0)) * k) / k)
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

def generate_wave_table_pulse_1_4(max)
  duty = 1.0 / 4.0
  generate_wave_table(max, "pulse_1_4", duty) do |t, k|
    (Math::cos(((2.0 * Math::PI) * (t / 256.0)) * k) * Math::sin(Math::PI * duty * k) / k)
  end
end

def generate_wave_table_pulse_1_8(max)
  duty = 1.0 / 8.0
  generate_wave_table(max, "pulse_1_8", duty) do |t, k|
    (Math::cos(((2.0 * Math::PI) * (t / 256.0)) * k) * Math::sin(Math::PI * duty * k) / k)
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
  generate_wave_table_pulse_1_4(max)
end

[128, 64, 32, 16, 8].each do |max|
  generate_wave_table_pulse_1_8(max)
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

$wave_table_pulse_1_4 = [
  $wave_table_pulse_1_4_m128,
  $wave_table_pulse_1_4_m64,
  $wave_table_pulse_1_4_m32,
  $wave_table_pulse_1_4_m32,
  $wave_table_pulse_1_4_m16,
  $wave_table_pulse_1_4_m16,
  $wave_table_pulse_1_4_m16,
  $wave_table_pulse_1_4_m16,
  $wave_table_pulse_1_4_m8,
]

$wave_table_pulse_1_8 = [
  $wave_table_pulse_1_8_m128,
  $wave_table_pulse_1_8_m64,
  $wave_table_pulse_1_8_m32,
  $wave_table_pulse_1_8_m32,
  $wave_table_pulse_1_8_m16,
  $wave_table_pulse_1_8_m16,
  $wave_table_pulse_1_8_m16,
  $wave_table_pulse_1_8_m16,
  $wave_table_pulse_1_8_m8,
]

$wave_tables = [
  $wave_table_saw,
  $wave_table_square,
  $wave_table_triangle,
  $wave_table_pulse_1_4,
  $wave_table_pulse_1_8,
]
EOS
