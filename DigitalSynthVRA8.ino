#include "Arduino.h"
#include "Common.h"
#include "Synth.h"
#include "SerialIn.h"
#include "AudioOut.h"

void setup() {
  Synth::initialize();
  SerialIn::open();
  AudioOut::open();
}

void loop() {
  while(true) {
#ifdef OPTION_DEMO_MODE
    static uint16_t count = 0;
    switch (count) {
    case      0: Synth::noteOn (48);       break;
    case   2500: Synth::noteOff(48);       break;
    case   5000: Synth::noteOn (53);       break;
    case   7500: Synth::noteOff(53);       break;
    case  10000: Synth::noteOn (55);       break;
    case  12500: Synth::noteOff(55);       break;
    case  15000: Synth::noteOn (53);       break;
    case  17500: Synth::noteOff(53);       break;
    case  19999: count = (uint16_t) 65535; break;
    }
    count++;
#else
    if (SerialIn::available()) {
      uint8_t b = SerialIn::read();
      Synth::receiveMIDIByte(b);
    }
#endif
    int8_t level = Synth::clock();
    AudioOut::write(level);
  }
}
