#include "Arduino.h"
#include "Common.h"
#include "Synth.h"
#include "AudioOut.h"

void setup() {
  Synth::initialize();
  Serial.begin(SERIAL_SPEED);
  AudioOut::open();
}

void loop() {
  while(true) {
    static boolean demo = true;
#if 0
    if (Serial.available() > 0) {
      uint8_t b = Serial.read();
      Synth::receiveMIDIByte(b);
    }
#else
// TODO: Demo Mode
    if (demo) {
      static uint16_t count = 0;
      switch (count) {
      case      0: Synth::noteOn (48); break;
      case   2500: Synth::noteOff(48); break;
      case   5000: Synth::noteOn (53); break;
      case   7500: Synth::noteOff(53); break;
      case  10000: Synth::noteOn (55); break;
      case  12500: Synth::noteOff(55); break;
      case  15000: Synth::noteOn (53); break;
      case  17500: Synth::noteOff(53); break;
      case  19999: count = 65535u;     break;
      }
      count++;
    }
#endif
    int8_t level = Synth::clock();
    AudioOut::write(level);
  }
}
