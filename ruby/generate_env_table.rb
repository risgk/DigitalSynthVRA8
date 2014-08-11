printf("$env_table_speed_from_time = [\n  ")
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
(0..127).each do |i|
  level = 128 - (128 * (0.5 ** ((i + 1) / 16.0))).round.to_i

  printf("%3d,", level)
  if i == 127
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
(0..127).each do |i|
  level = (128 * (0.5 ** ((i + 1) / 16.0))).round.to_i

  printf("%3d,", level)
  if i == 127
    printf("\n")
  elsif i % 16 == 15
    printf("\n  ")
  else
    printf(" ")
  end
end
printf("]\n")
