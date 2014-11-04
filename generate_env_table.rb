require './common'

$file = File::open("envTable.h", "w")

$file.printf("#pragma once\n\n")

$file.printf("const uint8_t g_envTableSpeedFromTime[] = {\n  ")
(0..127).each do |time|
  speed = (256.0 * (0.5 ** (time / 16.0))).round.to_i
  speed = 255 if speed == 256

  $file.printf("%3d,", speed)
  if time == 127
    $file.printf("\n")
  elsif time % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("};\n\n")

$env_table_attack = []

$file.printf("const uint8_t g_envTableAttack[] = {\n  ")
(0..127).each do |i|
  level = (3.0 / 2.0) * (127 - (127 * ((1.0 / Math::sqrt(3.0)) ** ((i + 1) / 64.0)))).round.to_i
  $env_table_attack[i] = level

  $file.printf("%3d,", level)
  if i == 127
    $file.printf("\n")
  elsif i % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("};\n\n")

$file.printf("const uint8_t g_envTableAttackInverse[] = {\n  ")
(0..127).each do |level|
  attack_count = 127
  (0..127).each do |i|
    if level <= $env_table_attack[i]
      attack_count = i
      break
    end
  end

  $file.printf("%3d,", attack_count)
  if level == 127
    $file.printf("\n")
  elsif level % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("};\n\n")

$env_table_decay = []

$file.printf("const uint8_t g_envTableDecay[] = {\n  ")
(0..255).each do |i|
  level = (127 * (0.5 ** (i / 25.4))).round.to_i
  $env_table_decay[i] = level

  $file.printf("%3d,", level)
  if i == 255
    $file.printf("\n")
  elsif i % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("};\n\n")

$file.printf("const uint8_t g_envTableDecayInverse[] = {\n  ")
(0..127).each do |level|
  decay_count = 255
  (0..255).each do |i|
    if level >= $env_table_decay[i]
      decay_count = i
      break
    end
  end

  $file.printf("%3d,", decay_count)
  if level == 127
    $file.printf("\n")
  elsif level % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("};\n\n")

$file.close
