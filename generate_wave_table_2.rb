require './common'

N = 256.0

$pulse_25 = [
   +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,
   +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,
   +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,
   +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
]

$pulse_12 = [
   +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,
   +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,  +80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
   -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,  -80,
]

$pseudo_tri = [
    +5,   +5,   +5,   +5,   +5,   +5,   +5,   +5,  +15,  +15,  +15,  +15,  +15,  +15,  +15,  +15,
   +25,  +25,  +25,  +25,  +25,  +25,  +25,  +25,  +35,  +35,  +35,  +35,  +35,  +35,  +35,  +35,
   +45,  +45,  +45,  +45,  +45,  +45,  +45,  +45,  +55,  +55,  +55,  +55,  +55,  +55,  +55,  +55,
   +65,  +65,  +65,  +65,  +65,  +65,  +65,  +65,  +75,  +75,  +75,  +75,  +75,  +75,  +75,  +75,
   +75,  +75,  +75,  +75,  +75,  +75,  +75,  +75,  +65,  +65,  +65,  +65,  +65,  +65,  +65,  +65,
   +55,  +55,  +55,  +55,  +55,  +55,  +55,  +55,  +45,  +45,  +45,  +45,  +45,  +45,  +45,  +45,
   +35,  +35,  +35,  +35,  +35,  +35,  +35,  +35,  +25,  +25,  +25,  +25,  +25,  +25,  +25,  +25,
   +15,  +15,  +15,  +15,  +15,  +15,  +15,  +15,   +5,   +5,   +5,   +5,   +5,   +5,   +5,   +5,
    -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,  -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,
   -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,
   -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,
   -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -75,  -75,  -75,  -75,  -75,  -75,  -75,  -75,
   -75,  -75,  -75,  -75,  -75,  -75,  -75,  -75,  -65,  -65,  -65,  -65,  -65,  -65,  -65,  -65,
   -55,  -55,  -55,  -55,  -55,  -55,  -55,  -55,  -45,  -45,  -45,  -45,  -45,  -45,  -45,  -45,
   -35,  -35,  -35,  -35,  -35,  -35,  -35,  -35,  -25,  -25,  -25,  -25,  -25,  -25,  -25,  -25,
   -15,  -15,  -15,  -15,  -15,  -15,  -15,  -15,   -5,   -5,   -5,   -5,   -5,   -5,   -5,   -5,
]

# refs http://d.hatena.ne.jp/ku-ma-me/20111124/p1#20111124f1
def fft(a)
  n = a.size
  return a if n == 1
  w = Complex.polar(1, -2 * Math::PI / n)
  a1 = fft((0 .. n / 2 - 1).map {|i| a[i] + a[i + n / 2] })
  a2 = fft((0 .. n / 2 - 1).map {|i| (a[i] - a[i + n / 2]) * (w ** i) })
  a1.zip(a2).flatten
end

def ifft(ffta)
  fft(ffta.map {|i| i.conj }).map {|i| i.conj }.map {|i| i / N }.map {|i| i.real.round }
end

def lpf(ffta, k)
  a = ffta.clone
  (k + 1 .. (N / 2)).each do |i|
    a[i] = 0.0
    a[N - i] = 0.0
  end
  return a
end

$fft_pulse_25 = fft($pulse_25)
$fft_pulse_12 = fft($pulse_12)
$fft_pseudo_tri = fft($pseudo_tri)

$file = File::open("WaveTable2.h", "w")

$file.printf("#pragma once\n\n")

def generate_wave_table(max, name, ffta)
  $file.printf("const uint8_t g_waveTable%sM%d[] PROGMEM = {\n  ", name, max)
  a = ifft(lpf(ffta, max))
  a.each_with_index do |level, t|
    $file.printf("%+4d,", level)
    if t == 255
      $file.printf("\n")
    elsif t % 16 == 15
      $file.printf("\n  ")
    else
      $file.printf(" ")
    end
  end
  $file.printf("};\n\n")
end

def generate_wave_table_pulse_25(max)
  generate_wave_table(max, "Pulse25", $fft_pulse_25)
end

def generate_wave_table_pulse_12(max)
  generate_wave_table(max, "Pulse12", $fft_pulse_12)
end

def generate_wave_table_pseudo_tri(max)
  generate_wave_table(max, "PseudoTri", $fft_pseudo_tri)
end

FREQ_MAX = 8819  # refs "FreqTable.h"

def max_from_i(i)
  max = 128 / (i + 1)
  max = 64 if max == 128
  max = max - 1 if max % 2 == 0
  return max
end

def generate_wave_tables(name)
  wave_table_sels = (0..(FREQ_MAX / 256))
  $file.printf("const uint8_t* g_waveTables%s[] = {\n", name)
  wave_table_sels.each do |i|
    $file.printf("  g_waveTable%sM%d,\n", name, max_from_i(i))
  end
  $file.printf("};\n\n")
end

overtones = (0..(FREQ_MAX / 256)).map { |i| max_from_i(i) }.uniq

overtones.each do |max|
  generate_wave_table_pulse_25(max)
end

overtones.each do |max|
  generate_wave_table_pulse_12(max)
end

overtones.each do |max|
  generate_wave_table_pseudo_tri(max)
end

generate_wave_tables("Pulse25")
generate_wave_tables("Pulse12")
generate_wave_tables("PseudoTri")

$file.close
