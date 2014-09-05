#include "Arduino.h"
#include "Common.h"
#include "Synth.h"
#include "AudioOut.h"

void setup() {
  Serial.begin(31250);
  AudioOut::open();
}

void loop() {
  if (Serial.available() > 0) {
    uint8_t b = Serial.read();
    Synth::receiveMIDIByte(b);
  }
  int8_t level = Synth::clock();
  AudioOut::write(level);
}
