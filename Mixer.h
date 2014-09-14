#pragma once

#include "Common.h"

class Mixer
{
public:
  static int8_t clock(int8_t a, int8_t b, int8_t c)
  {
    return (a + b + c) >> 2;
  }
};
