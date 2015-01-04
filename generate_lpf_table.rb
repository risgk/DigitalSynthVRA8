# refs http://www.musicdsp.org/files/Audio-EQ-Cookbook.txt
# Cookbook formulae for audio EQ biquad filter coefficients
# by Robert Bristow-Johnson

require './common'

$file = File::open("LPFTable.h", "w")

$file.printf("#pragma once\n\n")

def generate_lpf_table(name, q)
  $file.printf("const uint8_t g_lpfTable%s[] PROGMEM = {\n  ", name)
  (0..127).each do |i|
    f0_over_fs = (2.0 ** (i / (127.0 / 3.0))) / (2.0 ** 5.0)
    w0 = 2.0 * Math::PI * f0_over_fs
    alpha = Math::sin(w0) / (2.0 * q)

    b2 = (1.0 - Math::cos(w0)) / 2.0
    a0 = 1.0 + alpha
    a1 = (-2.0) * Math::cos(w0)
    a2 = 1.0 - alpha

    b2_over_a0   = ((b2 / a0) * 128.0).round.to_i
    a1_over_a0_i = ((a1 / a0) * -128.0).round.to_i
    a2_over_a0   = (b2_over_a0 * 4) + a1_over_a0_i - 128

    $file.printf("%4d, %4d, %4d,", b2_over_a0, a1_over_a0_i, a2_over_a0)
    if i == 127
      $file.printf("\n")
    elsif i % 4 == 3
      $file.printf("\n  ")
    else
      $file.printf(" ")
    end
  end
  $file.printf("};\n\n")
end

generate_lpf_table("Q1OverSqrt2", 1.0 / Math::sqrt(2.0))
generate_lpf_table("QSqrt2", Math::sqrt(2.0))

$file.close
