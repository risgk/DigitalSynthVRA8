require './common'

$file = File::open("envTable.h", "w")

$file.printf("#pragma once\n\n")

$file.printf("const uint16_t g_envTableAttackRateFromTime[] = {\n  ")
(0..127).each do |time|
  speed = 10.0 / (10.0 ** ((127.0 - time) / (127.0 / 3.0)))
  rate = ((1.0 / 3.0) ** (1.0 / ((SAMPLING_RATE / EG_UPDATE_INTERVAL) * speed)))

  r = (rate * 0x10000 + 2.0).round.to_i
  $file.printf("0x%04X,", r)
  if time == 127
    $file.printf("\n")
  elsif time % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("};\n\n")

$file.printf("const uint16_t g_envTableDecayRateFromTime[] = {\n  ")
(0..127).each do |time|
  speed = 10.0 / (10.0 ** ((127.0 - time) / (127.0 / 3.0)))
  rate = ((1.0 / 32.0) ** (1.0 / ((SAMPLING_RATE / EG_UPDATE_INTERVAL) * speed)))

  r = (rate * 0x10000 + 2.0).round.to_i
  $file.printf("0x%04X,", r)
  if time == 127
    $file.printf("\n")
  elsif time % 16 == 15
    $file.printf("\n  ")
  else
    $file.printf(" ")
  end
end
$file.printf("};\n\n")
