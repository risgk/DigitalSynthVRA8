// refs http://playground.arduino.cc/Code/PCMAudio

#pragma once

#include "Common.h"

class AudioOut
{
  static const int SPEAKER_PIN = 6;   // PD6 (OC0A)
  static const int LED_PIN     = 13;  // PB5

public:
  static void open()
  {
    pinMode(SPEAKER_PIN, OUTPUT);
    pinMode(LED_PIN,     OUTPUT);

    // Timer/Counter0 (8-bit Fast PWM, Inverting, 62500 Hz)
    TCCR0A = 0xC3;
    TCCR0B = 0x01;
    OCR0A  = 0x80;

    // Timer/Counter1 (10-bit Fast PWM, 15625 Hz)
    TCCR1A = 0x03;
    TCCR1B = 0x09;
  }

  static void write(int8_t level)
  {
#ifdef OPTION_OVERLOAD_LED
    if (TIFR1 & _BV(TOV1)) {
      PORTB |= _BV(5);
    } else {
      PORTB &= ~_BV(5);
    }
#endif
    while ((TIFR1 & _BV(TOV1)) == 0);
    TIFR1 = _BV(TOV1);
    OCR0A = (uint8_t) 0x80 - (uint8_t) level;
  }
};
