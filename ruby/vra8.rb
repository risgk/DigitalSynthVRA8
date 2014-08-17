require './common'
require './synth'
require './wav_file_out'

$synth = Synth.new

if ARGV.length == 1
  File::open(ARGV[0], "rb") do |bin_file|
    WavFileOut::open("a.wav") do |wav_file|
      while(c = bin_file.read(1)) do
        b = c.ord
        $synth.receive_midi_byte(b)
        10.times do
          level = $synth.clock
          wav_file.write(level)
        end
      end
    end
  end
elsif
  # todo
  raise
end
