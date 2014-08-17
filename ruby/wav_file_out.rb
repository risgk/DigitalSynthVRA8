class WavFileOut
  def self.open(path)
    File::open(path, "wb") do |file|
      file.write("RIFF")
      file.write([0].pack("V"))
      file.write("WAVE")
      file.write("fmt ")
      file.write([16].pack("V"))
      file.write([1, 1].pack("v*"))
      file.write([AUDIO_RATE, AUDIO_RATE].pack("V*"))
      file.write([1, 8].pack("v*"))
      file.write("data")
      file.write([0].pack("V"))

      yield WavFile.new(file)

      file_size = file.size
      file.seek(4, IO::SEEK_SET)
      file.write([file_size - 8].pack("V"))
      file.seek(40, IO::SEEK_SET)
      file.write([file_size - 36].pack("V"))
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
