require './common'
require './synth'
require './wav_file_out'

$synth = Synth.new

File::open(ARGV[0], "rb") do |bin_file|
  WavFileOut::open("a.wav") do |wav_file|
    while(c = bin_file.read(1)) do
      b = c.ord
      $synth.receive_midi_byte(b)
      for i in (0...10) do
        level = $synth.clock
        wav_file.write([level * 128].pack("S"))
      end
    end
  end
end
