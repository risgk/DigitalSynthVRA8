# main

require './common'
require './synth'
require './audio_out'
require './wav_file_out'

$synth = Synth.new

if ARGV.length == 1
  File::open(ARGV[0], "rb") do |bin_file|
    wav_file_out = WAVFileOut.new("./a.wav")
    while(c = bin_file.read(1)) do
      b = c.ord
      $synth.receive_midi_byte(b)
      10.times do
        level = $synth.clock
        wav_file_out.write(level)
      end
    end
    wav_file_out.close
  end
else
  require 'unimidi'
  require "thread"
  q = Queue.new
  t = Thread.new do
    wav_file_out = WAVFileOut.new("./a.wav") if OPTION_RECORDING
    AudioOut::open
    loop do
      if (!q.empty?)
        n = q.pop
        n.each do |e|
          e[:data].each do |b|
            $synth.receive_midi_byte(b)
          end
        end
      end
      level = $synth.clock
      wav_file_out.write(level) if OPTION_RECORDING
      AudioOut::write(level)
    end
  end
  UniMIDI::Input.gets do |input|
    loop do
      m = input.gets
      q.push(m)
    end
  end
end
