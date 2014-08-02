def generate_freq_table(fine_tune, name)
  printf("$freq_table%s = [\n  ", name)
  (0..127).each do |note_number|
    cent = (note_number * 100.0) - 6900.0 + fine_tune
    hz = 440.0 * (2.0 ** (cent / 1200.0))
    freq = (hz * 256.0 * 256.0 / 31250.0).truncate

    printf("0x%04X,", freq)
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

generate_freq_table(0.0, "")
generate_freq_table(10.0, "_plus_tune")
generate_freq_table(-10.0, "_minus_tune")

print <<EOS
$freq_tables = [
  $freq_table,
  $freq_table_plus_tune,
  $freq_table_minus_tune,
]
EOS
