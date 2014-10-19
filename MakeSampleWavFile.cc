#define PROGMEM

typedef signed   char  boolean;
typedef signed   char  int8_t;
typedef unsigned char  uint8_t;
typedef signed   short int16_t;
typedef unsigned short uint16_t;
typedef unsigned int   uint32_t;

inline uint8_t pgm_read_byte(const uint8_t* p)
{
  return *p;
}

inline uint16_t pgm_read_word(const uint16_t* p)
{
  return *p;
}

inline uint8_t highByte(uint16_t ui16)
{
  return ui16 >> 8;
}

inline uint8_t lowByte(uint16_t ui16)
{
  return ui16 & 0xFF;
}

#include <stdio.h>
#include "Common.h"
#include "Synth.h"
#include "WAVFileOut.h"

int main()
{
  // setup
  Synth::initialize();
  FILE* binFile = ::fopen("./sample_midi_stream.bin", "rb");
  WAVFileOut::open("./a.wav");

  // loop
  int c;
  while ((c = ::fgetc(binFile)) != EOF) {
    uint8_t b = static_cast<uint8_t>(c);
    Synth::receiveMIDIByte(b);
    for (uint16_t i = 0; i < 4; i++) {
      uint8_t level = Synth::clock();
      WAVFileOut::write(level);
    }
  }

  // teardown
  WAVFileOut::close();
  ::fclose(binFile);

  return 0;
}
