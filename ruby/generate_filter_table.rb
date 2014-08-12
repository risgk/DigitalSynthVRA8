# refs http://www.musicdsp.org/files/Audio-EQ-Cookbook.txt

(0..1).each do |r|
  printf("$filter_table_%s = [\n  ", (r == 1) ? "reso_off" : "reso_on")
  (0..127).each do |i|
    f0_fs = (2.0 ** (i / 32.0)) / (2.0 ** 5.0)
    w0 = 2.0 * Math::PI * f0_fs
    if r == 1
      q = 1.0 / Math::sqrt(2.0)
    else
      q = 4.0
    end
    alpha = Math::sin(w0) / (2.0 * q)

    b1 = 1.0 - Math::cos(w0)
    b2 = (1.0 - Math::cos(w0)) / 2.0
    a0 = 1.0 + alpha
    a1 = -2.0 * Math::cos(w0)
    a2 = 1.0 - alpha

    if a1 >= 0
      a1_a0_pos = 1
    else
      a1_a0_pos = 0
    end
    b1_a0 = ((b1 / a0) * 128).round.abs.to_i
    b2_a0 = ((b2 / a0) * 128).round.abs.to_i + (a1_a0_pos * 128)
    a1_a0 = ((a1 / a0) * 128).round.abs.to_i
    a2_a0 = ((a2 / a0) * 128).round.abs.to_i

    printf("[%3d, %3d, %3d, %3d],", b1_a0, b2_a0, a1_a0, a2_a0)
    if i == 127
      printf("\n")
    elsif i % 4 == 3
      printf("\n  ")
    else
      printf(" ")
    end
  end
  printf("]\n\n")
end

print <<EOS
$filter_tables = [
  $filter_table_reso_off,
  $filter_table_reso_on,
]
EOS
