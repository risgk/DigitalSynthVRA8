def fft(a)
  ditfft2(a, a.size, 1)
end

# refs http://en.wikipedia.org/wiki/Cooley%E2%80%93Tukey_FFT_algorithm
# Cooley–Tukey FFT algorithm - Wikipedia, the free encyclopedia
def ditfft2(x, n, s)
  result = []
  if n == 1 then
    result[0] = x[0]
  else
    result += ditfft2(x,         n / 2, 2 * s)
    result += ditfft2(x.drop(s), n / 2, 2 * s)
    for k in 0..(n / 2 - 1) do
      t = result[k]
      result[k]         = t + (Math::E ** Complex(0, -2 * Math::PI * k / n)) * result[k + n / 2]
      result[k + n / 2] = t - (Math::E ** Complex(0, -2 * Math::PI * k / n)) * result[k + n / 2]
    end
  end
  result
end
