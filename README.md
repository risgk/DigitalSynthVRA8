# Digital Synthesizer ISGK VRA-8 Series

Version 0.00: 2014-08-12 risgk

## Concept

- 8-bit Virtual Analog Synthesizer

## ISGK VRA-8A Features

- Arduino Uno, Buzzer, Serial MIDI
- Audio Rate: 31250 Hz
- PWM Audio (PWM Rate: 31250 Hz)

## ISGK VRA-8R Features

- Prototype of VRA-8A
- Soft Synthesizer for Windows
- Ruby (win32-sound, unimidi)
- Audio Rate: 32000 Hz

## Sound Quality

- Bit Depth: 8 bits
- Monophonic
- Recommended Note Range: 36-84
- Exp/Log Envelope

## Modules

- OSC1:
    - WAVE: [SAW, SQUARE, TRIANGLE]
- OSC2:
    - WAVE: [SAW, SQUARE, TRIANGLE]
    - TUNE: [-1200, -500, 0, +700, +1200] cent
    - FINE: [-10, 0, +10] cent
- OSC3:
    - WAVE: [SAW, SQUARE, TRIANGLE]
    - TUNE: [-1200, -500, 0, +700, +1200] cent
    - FINE: [-10, 0, +10] cent
- LPF:
    - CUTOFF: [AR/32, AR/16, AR/8, AR/4, AR/2]
    - RESO: [OFF, ON]
    - ENV: [OFF, ON]
- AMP:
    - ENV: [OFF, ON]
- ENV:
    - A: [8, 16, 33, 65, 131, 261, 522, 1044, 2089] ms
    - D: [8, 16, 33, 65, 131, 261, 522, 1044, 2089] ms
    - S: [0, ..., 1/4, ..., 1/2, ..., 3/4, ..., 127/128]
    - R: [8, 16, 33, 65, 131, 261, 522, 1044, 2089] ms

## Preset Programs

- Saw Lead (Unison, Fifth, Bass, Octave, ...)
- Square Lead (Unison, Fifth, Bass, Octave, ...)
- Synth Bass
- Synth Brass
- Synth Strings
- Synth Pad
- ...
- TODO

## MIDI Implementation Chart

    TODO
