// refs http://playground.arduino.cc/Code/PCMAudio

#pragma once

#include "Common.h"

class AudioOut
{
  static const int SPEAKER_PIN = 6;
  static const int LED_PIN     = 13;

public:
  inline static void open()
  {
    // Speaker
    pinMode(SPEAKER_PIN, OUTPUT);
    pinMode(LED_PIN,     OUTPUT);

    // Timer 0 (62500 Hz)
    TCCR0A = (uint8_t) 0xC3;
    TCCR0B = (uint8_t) 0x01;
    OCR0A  = (uint8_t) 0x80;

    // Timer 1 (15625 Hz)
    TCCR1A = (uint8_t) 0x03;
    TCCR1B = (uint8_t) 0x09;
  }

  inline static void write(int8_t level)
  {
    if ((TIFR1 & 0x01) == 0) {
      PORTB |= _BV(5);
    } else {
      PORTB &= ~_BV(5);
    }
    while ((TIFR1 & 0x01) == 0);
    TIFR1 = 0x01;
    OCR0A = (uint8_t) 0x80 - (uint8_t) level;
  }
};
