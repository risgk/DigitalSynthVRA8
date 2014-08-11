printf("$env_table_attack = [\n  ")
(0..255).each do |i|
  level = 256 - (256 * (0.5 ** ((i + 1) / 32.0))).floor.to_i

  printf("%3d,", level)
  if i == 255
    printf("\n")
  elsif i % 16 == 15
    printf("\n  ")
  else
    printf(" ")
  end
end
printf("]\n\n")

printf("$env_table_decay_release = [\n  ")
(0..255).each do |i|
  level = (256 * (0.5 ** ((i + 1) / 32.0))).floor.to_i

  printf("%3d,", level)
  if i == 255
    printf("\n")
  elsif i % 16 == 15
    printf("\n  ")
  else
    printf(" ")
  end
end
printf("]\n\n")
