require './common'
require './synth'
require './wav_file'

$synth = Synth.new

if ARGV.length == 1
  File::open(ARGV[0], "rb") do |bin_file|
    wav_file = WavFile.new("./a.wav")
    while(c = bin_file.read(1)) do
      b = c.ord
      $synth.receive_midi_byte(b)
      10.times do
        level = $synth.clock
        wav_file.write(level)
      end
    end
    wav_file.close
  end
else
  require 'unimidi'
  require "thread"
  BUFFER_SIZE = 1000
  q = Queue.new
  t = Thread.new do
    wav_file = WavFile.new("./a.wav")
    t0 = Time.now
    loop do
      if (!q.empty?)
        n = q.pop
        n.each do |e|
          e[:data].each do |b|
            $synth.receive_midi_byte(b)
          end
        end
      end

      begin
        t1 = Time.now
        t = (t1.usec - t0.usec) % 1000000
      end while (t < BUFFER_SIZE * 1000000 / AUDIO_RATE)
      t0 = Time.now

      BUFFER_SIZE.times do
        level = $synth.clock
        wav_file.write(level)
      end
    end
  end
  UniMIDI::Input.gets do |input|
    loop do
      m = input.gets
      q.push(m)
    end
  end
end
