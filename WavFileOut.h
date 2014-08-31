#pragma once

// TODO

#include "Common.h"

class WavFileOut
{
public:
        inline static void initialize()
        {
                // TODO
        }

        inline static void open(const char* path)
        {
                // TODO
        }

        inline static void write(uint8_t level)
        {
                // TODO
        }

        inline static void close()
        {
                // TODO
        }
};

#if 0

class WavFileOut
  SEC = 30

  def initialize(path)
    @file = File::open(path, "wb")
    @file.write("RIFF")
    @file.write([0].pack("V"))
    @file.write("WAVE")
    @file.write("fmt ")
    @file.write([16].pack("V"))
    @file.write([1, 1].pack("v*"))
    @file.write([SAMPLING_RATE, SAMPLING_RATE].pack("V*"))
    @file.write([1, 8].pack("v*"))
    @file.write("data")
    @file.write([0].pack("V"))
    @max_size = SAMPLING_RATE * SEC
    @data_size = 0
    @closed = false
  end

  def write(level)
    if (@data_size < @max_size)
      @file.write([level + 0x80].pack("C"))
      @data_size += 1
    else
      close
      @closed = true
    end
  end

  def close
    if (!@closed)
      file_size = @file.size
      @file.seek(4, IO::SEEK_SET)
      @file.write([file_size - 8].pack("V"))
      @file.seek(40, IO::SEEK_SET)
      @file.write([file_size - 36].pack("V"))
      @file.close
      puts "Recording end."
    end
  end
end

#endif
