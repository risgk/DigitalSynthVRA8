# Digital Synth "ISGK VA-8" Prototype in Ruby

Version 0.00: 2014-08-05 risgk

## Concept

- 8-bit Virtual Analog Synth

## Target Form

- Arduino Uno
- Buzzer
- PWM Audio
- C++
- Serial MIDI
- Controller App

## Sound Quality

- PWM Rate: 31250 Hz
- Audio Rate: 31250 Hz
- Bit Depth: 8 bits
- Recommended Note Range: 24-96
- Exponential Envelope
- Monophonic

## Synth Modules

- OSC1:
    - WAVE: [SAW, SQUARE, SINE]
- OSC2:
    - WAVE: [SAW, SQUARE, SINE]
    - TUNE: [-1200, -500, 0, +700, +1200]
    - FINE: [-10, 0, +10]
    - VOL: [0, 1/4, 1/2, 1]
- OSC3:
    - WAVE: [SAW, SQUARE, SINE]
    - TUNE: [-1200, -500, 0, +700, +1200]
    - FINE: [-10, 0, +10]
    - VOL: [0, 1/4, 1/2, 1]
- LPF:
    - CUTOFF: [1875, ..., 3750, ..., 7500, ..., 15000]
    - RESO: [OFF, ON]
    - ENV: [OFF, ON]
- AMP:
    - VOL: [0, 1/4, 1/2, 1]
    - ENV: [OFF, ON]
- ENV:
    - A: [???, ..., ???]
    - D: [???, ..., ???]
    - S: [0, 1/4, 1/2, 1]
    - R: [???, ..., ???]

## Preset Programs

- Synth Brass
- Saw Lead
- Square Lead
- Synth Bass
- TODO

## MIDI Implementation Chart

    TODO
