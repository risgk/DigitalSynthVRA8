#pragma once

#include "Common.h"

class AudioOut
{
public:
  inline static void open()
  {
    // TODO
    pinMode(13, OUTPUT);
  }

  inline static void write(int8_t level)
  {
    // TODO
    // pin 13
    PORTB |= _BV(5);
    delay(1000);
    PORTB &= ~_BV(5);
    delay(1000);
  }
};
