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

$env_table_attack = []

$file.printf("$env_table_attack = [\n  ")
(0..254).each do |i|
  level = 256 - (256 * (0.5 ** ((i + 1) / 30.0))).round.to_i
  $env_table_attack[i] = level

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

$file.printf("$env_table_attack_count_from_level = [\n  ")
(0..126).each do |level|
  attack_count = 255
  (0..254).each do |i|
    if level <= high_byte($env_table_attack[i] * 127)
      attack_count = i
      break
    end
  end

  $file.printf("%3d,", attack_count)
  if level == 126
    $file.printf("\n")
  elsif level % 16 == 15
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
