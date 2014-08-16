# refs http://www.musicdsp.org/files/Audio-EQ-Cookbook.txt

$file = File::open("filter_table.rb", "wb")

(0..1).each do |r|
  $file.printf("$filter_table_%s = [\n  ", r == 1 ? "reso_on" : "reso_off")
  (0..127).each do |i|
    f0fs = (2.0 ** (i / (127.0 / 2.0))) / (2.0 ** 4.0)
    w0 = 2.0 * Math::PI * f0fs
    if r == 1
      q = Math::sqrt(2.0)
    else
      q = 1.0 / Math::sqrt(2.0)
    end
    alpha = Math::sin(w0) / (2.0 * q)

    b1 = 1.0 - Math::cos(w0)
    b2 = (1.0 - Math::cos(w0)) / 2.0
    a0 = 1.0 + alpha
    a1 = -2.0 * Math::cos(w0)
    a2 = 1.0 - alpha

    b1a0 = ((b1 / a0) * 64).round.to_i
    b2a0 = ((b2 / a0) * 64).round.to_i
    a1a0 = ((a1 / a0) * -64).round.to_i
    a2a0 = ((a2 / a0) * 64).round.to_i

    $file.printf("[%3d, %3d, %3d, %3d],", b1a0, b2a0, a1a0, a2a0)
    if i == 127
      $file.printf("\n")
    elsif i % 4 == 3
      $file.printf("\n  ")
    else
      $file.printf(" ")
    end
  end
  $file.printf("]\n\n")
end

$file.print <<EOS
$filter_tables = [
  $filter_table_reso_off,
  $filter_table_reso_on,
]
EOS

$file.close
