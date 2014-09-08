#pragma once

#include "Common.h"

class Mixer
{
public:
  inline static int8_t clock(int8_t a, int8_t b, int8_t c)
  {
    return ((int16_t) a + b + c) >> 2;
  }
};
