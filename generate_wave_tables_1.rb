def generate_table(max,name)
  printf("$wave_table_%s_%d = [\n  ", name, max)
  (0..255).each do |index|
    level = 0
    (1..max).each do |overtone|
      level += yield(index, overtone)
    end
    level = ((level + 2) * 64).to_i
      printf("0x%02X,", level)
    if index % 256 == 255
      printf("\n")
    elsif index % 16 == 15
      printf("\n  ")
    else
      printf(" ")
    end
  end
  printf("]\n\n")
end

def generate_saw_table(max)
  generate_table(max,"saw") do |index, overtone|
    Math::sin((2.0 * Math::PI) * index * overtone / 256) / overtone
  end
end

def generate_square_table(max)
  generate_table(max, "square") do |index, overtone|
    if overtone % 2 == 1
      Math::sin((2.0 * Math::PI) * index * overtone / 256) / overtone
    else
      0
    end
  end
end

def generate_triangle_table(max)
  generate_table(max, "triangle") do |index, overtone|
    if overtone % 2 == 1
      Math::sin((2.0 * Math::PI) * index * overtone / 256) / (overtone ** 2)
    else
      0
    end
  end
end

def generate_sine_table(max)
  generate_table(max, "sine") do |index, overtone|
    if overtone == 1
      Math::sin((2.0 * Math::PI) * index * overtone / 256) / overtone
    else
      0
    end
  end
end

[128, 64, 32, 16, 8].each do |i|
  generate_saw_table(i)
end

[128, 64, 32, 16, 8].each do |i|
  generate_square_table(i)
end

[128, 64, 32, 16, 8].each do |i|
  generate_triangle_table(i)
end

[128, 64, 32, 16, 8].each do |i|
  generate_sine_table(i)
end
