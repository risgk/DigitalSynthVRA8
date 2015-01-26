def fft(a)
  n = a.size
  return a if n == 1
  w = Complex.polar(1, -2 * Math::PI / n)
  a1 = fft((0 .. n / 2 - 1).map {|i| a[i] + a[i + n / 2] })
  a2 = fft((0 .. n / 2 - 1).map {|i| (a[i] - a[i + n / 2]) * (w ** i) })
  a1.zip(a2).flatten
end
