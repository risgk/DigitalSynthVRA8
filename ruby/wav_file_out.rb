require './common'

class WavFileOut
  def self.open(path)
    File::open(path, "wb") do |f|
      f.write("RIFF")
      f.write([0].pack("V"))
      f.write("WAVE")
      f.write("fmt ")
      f.write([16].pack("V"))
      f.write([1, 1].pack("v*"))
      f.write([AUDIO_RATE, AUDIO_RATE].pack("V*"))
      f.write([1, 8].pack("v*"))
      f.write("data")
      f.write([0].pack("V"))

      yield WavFile.new(f)

      file_size = f.size
      f.seek(4, IO::SEEK_SET)
      f.write([file_size - 8].pack("V"))
      f.seek(40, IO::SEEK_SET)
      f.write([file_size - 36].pack("V"))
    end
  end
end

class WavFile
  def initialize(file)
    @file = file
  end

  def write(level)
    @file.write([level + 0x80].pack("C"))
  end
end
