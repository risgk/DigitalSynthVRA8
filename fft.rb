# refs http://en.wikipedia.org/wiki/Cooley%E2%80%93Tukey_FFT_algorithm
# Cooley–Tukey FFT algorithm - Wikipedia, the free encyclopedia

def fft(a)
  ditfft2(a, a.size, 1)
end

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

def ifft(ffta, amp)
  n = ffta.size
  fft(ffta.map {|i| i.conj }).map {|i| i.conj }.map {|i| i * amp / n }.map {|i| i.real.round }
end

def lpf_fft(ffta, k)
  n = ffta.size
  a = ffta.clone
  (k + 1 .. (n / 2)).each do |i|
    a[i] = 0.0
    a[n - i] = 0.0
  end
  return a
end
