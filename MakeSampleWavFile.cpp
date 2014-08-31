typedef signed   char  int8_t;
typedef unsigned char  uint8_t;
typedef signed   short int16_t;
typedef unsigned short uint16_t;

inline uint8_t HighByte(uint16_t ui16)
{
        return (ui16 >> 8);
}

inline uint8_t LowByte(uint16_t ui16)
{
        return (ui16 & 0xFF);
}

#define PROGMEM

#include "stdio.h"
#include "Common.h"
#include "WavFileOut.h"

int main()
{
        // setup
        // TODO

        // loop
        // TODO
        File::open(ARGV[0], "rb") do |bin_file|
                wav_file_out = WavFileOut.new("./a.wav")
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

        return 0;
}
