# Digital Synth VA-8 Specification

Version 0.00: 2014-07-28 risgk

## Concept

- 8-bit Virtual Analog Synth

## Keywords

- Monophonic Synth
- Arduino Uno
- Buzzer/Speaker
- Serial MIDI
- Controller App

## Sound Quality

- PWM Rate: 31250 Hz
- Audio Rate: 31250 Hz
- Bit Depth: 8 bits
- Note Number: 24-96
- Waveform Memory:
    - 256 Bytes for Notes 24-46 Include the 128th Overtones
    - 256 Bytes for Notes 47-58 Include the 64th Overtones
    - 256 Bytes for Notes 59-70 Include the 32nd Overtones
    - 256 Bytes for Notes 71-82 Include the 16th Overtones
    - 256 Bytes for Notes 83-96 Include the 8th Overtones
- Exponential Envelope

## Synth Modules

- OSC1:
    - WAVE
    - PITCH: [-1200, -500, -10, 0, +10, +700, +1200]
    - LEVEL: [0, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1]
- OSC2:
    - WAVE
    - PITCH
    - LEVEL
- OSC3:
    - WAVE
    - PITCH
    - LEVEL
- LPF:
    - CUTOFF: [1875, ..., 3750, ..., 7500, ..., 15000]
    - RESO: [OFF, ON]
    - ENV: [OFF, ON]
- AMP:
    - LEVEL: [0, 1/64, 1/32, 1/16, 1/8, 1/4, 1/2, 1]
    - ENV: [OFF, ON]
- ENV:
    - A
    - D
    - S
    - R

## Waveforms

- Saw
- Square (Pulse 1/2)
- Triangle
- Pulse 1/4
- Pulse 1/8

## Preset Programs

- Synth Lead
- Synth Bass
- Saw Lead
- Square Lead
- Synth Brass

## MIDI Implementation Chart

    TODO
