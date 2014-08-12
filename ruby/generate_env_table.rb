printf("$env_table_speed = [\n  ")
(0..127).each do |time|
  speed = (2 ** (8 - ((time + 8) / 16)))

  printf("%3d,", speed)
  if time == 127
    printf("\n")
  elsif time % 16 == 15
    printf("\n  ")
  else
    printf(" ")
  end
end
printf("]\n")

printf("\n")

printf("$env_table_attack = [\n  ")
(0..254).each do |i|
  level = 256 - (256 * (0.5 ** ((i + 1) / 32.0))).round.to_i

  printf("%3d,", level)
  if i == 254
    printf("\n")
  elsif i % 16 == 15
    printf("\n  ")
  else
    printf(" ")
  end
end
printf("]\n")

printf("\n")

printf("$env_table_decay_release = [\n  ")
(0..254).each do |i|
  level = (256 * (0.5 ** ((i + 1) / 32.0))).round.to_i

  printf("%3d,", level)
  if i == 254
    printf("\n")
  elsif i % 16 == 15
    printf("\n  ")
  else
    printf(" ")
  end
end
printf("]\n")

print <<EOS
$env_table_sustain = [
    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
   31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,
   31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,  31,
   63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,
   63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,  63,
   95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,
   95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,  95,
  127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
]
EOS
