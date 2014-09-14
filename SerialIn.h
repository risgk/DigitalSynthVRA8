#pragma once

#include "Common.h"

class SerialIn
{
public:
  static void open()
  {
    UBRR0 = (1000000 / SERIAL_SPEED) - 1;
    UCSR0B = _BV(RXEN0);
  }

  static boolean available()
  {
    return UCSR0A & _BV(RXC0);
  }

  static int8_t read()
  {
    return UDR0;
  }
};
