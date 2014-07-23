# Digital Synth (Tentative) Specification

2014-07-23 risgk

## Concept

- 8-bit Virtual Analog (VA) Synthesizer

## Features

- Monophonic Synthesizer
- Arduino Uno
- Piezo buzzer (or audio jack)
- Serial MIDI (31250 bps)
- Ruby programming language (for MIDI controller)

## Sound Quality

- PWM rate: 31250 Hz
- Audio rate: 31250 Hz
- Bit depth: 8 bits
- Waveform memory: 256 samples, 8 bits
    - Notes 0-58 include the 128th overtones
    - Notes 59-70 include the 32nd overtones
    - Notes 71-82 include the 16th overtones
    - Notes 83-94 include the 8th overtones

## Synth Modules

- UART
- CTRL
- OSC 1, OSC 2, OSC 3, OSC 4
    - WAVEFORM
    - PITCH
    - TUNE
    - LEVEL
- FILTER
    - CUTOFF
    - RESO
    - ENV
    - A
    - D
    - S
    - R
- AMP
    - ENV
    - A
    - D
    - S
    - R
- PWM
    - VOLUME

## Preset Programs

- Synth Lead
- Synth Bass
- Saw Lead
- Square Lead
- Synth Brass

## Waveform

- 0x00: Saw
- 0x01: Pulse 12.5%
- 0x02: Pulse 25%
- 0x03: Pulse 37.5%
- 0x04: Square (Pulse 50%)
- 0x05: Triangle
- 0x06: Sine

## MIDI Implementation Chart [TODO]

- CC #120: All Sound Off
- CC #121: Reset All Controllers
- CC #123: All Notes Off
