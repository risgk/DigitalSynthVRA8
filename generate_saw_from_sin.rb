printf("  ")
(0..255).each do |i|
  v = 0
  (1..16).each do |j|
    v += Math::sin(Math::PI * 2.0 * i * j / 256) / j
  end
  v = ((v + 2) * 64).to_i
  printf("0x%02X,",v)
  
  if i % 256 == 255
    printf("\n")
  elsif i % 16 == 15
    printf("\n  ")
  else
    printf(" ")
  end
end
