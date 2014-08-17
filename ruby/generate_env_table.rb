require './common'

$file = File::open("env_table.rb", "wb")

$file.printf("$env_table_speed_from_time = [\n  ")
(0..127).each do |time|
  speed = (2 ** (8 - ((time + 8) / 16)))

  $file.printf("%3d,", speed)
  if time == 127
    $file.printf("\n")
  elsif time % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("]\n")

$file.printf("\n")

$file.printf("$env_table_attack = [\n  ")
(0..254).each do |i|
  level = 256 - (256 * (0.5 ** ((i + 1) / 30.0))).round.to_i

  $file.printf("%3d,", level)
  if i == 254
    $file.printf("\n")
  elsif i % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("]\n")

$file.printf("\n")

$file.printf("$env_table_decay_release = [\n  ")
(0..254).each do |i|
  level = (256 * (0.5 ** ((i + 1) / 30.0))).round.to_i

  $file.printf("%3d,", level)
  if i == 254
    $file.printf("\n")
  elsif i % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("]\n")

$file.close
