def generate_freq_table(fine_tune, name)
  printf("$freq_table%s = [\n  ", name)
  (0..127).each do |note_number|
    cent = (note_number * 100.0) - 6900.0 + fine_tune
    hz = 440.0 * (2.0 ** (cent / 1200.0))
    freq = (hz * 256.0 * 256.0 / 31250.0).floor

    printf("%5d,", freq)
    if note_number == 127
      printf("\n")
    elsif note_number % 12 == 11
      printf("\n  ")
    else
      printf(" ")
    end
  end
  printf("]\n\n")
end

generate_freq_table(-10.0, "_fine_tune_minus_10")
generate_freq_table(0.0, "_fine_tune_normal")
generate_freq_table(10.0, "_fine_tune_plus_10")

print <<EOS
$freq_tables = [
  $freq_table_fine_tune_minus_10,
  $freq_table_fine_tune_normal,
  $freq_table_fine_tune_plus_10,
]
EOS
