# Digital Synth (Tentative) Specification

2014-07-21 risgk

## Features

- Digital synthesizer
- 8-bit sound (4 channels, 4 voices)
- Performance mode (2-4 voices layered)
- Arduino Uno
- Piezo buzzer (or audio jack)
- Ruby programming language (for MIDI controller)

## Sound Quality

- PWM rate: 62500 Hz
- Audio rate: 31250 Hz
- Bit depth: 8 bits
- Waveform memory: 32 samples, 4 bits

## Synth Modules

- MIDI IN (UART RX)
- CTRL
- LFO * 4
- OSC * 4
- EG * 4
- AMP * 4
- MIXER
- FILTER (LPF)
- DAC (PWM OUT)

## Initial Settings

- Mode 4 (Omni Off, Mono)
- Ch #1 (0x00): Saw Lead
- Ch #2 (0x01): Square Lead
- Ch #3 (0x02): Triangle Lead
- Ch #4 (0x03): Drums
- Ch #10: Treated as Ch #4
- Channel Volume: 0x7F
- Channel Fine Tuning: 0x40
- Channel Coarse Tuning: 0x40

## Program Change

- 0x00-0x1F: (Waveform: 0x00-0x1F) Lead
- 0x20: PF Saw Lead
- 0x21: PF Mixed Lead
- 0x22: PF Synth Brass
- 0x23: PF Synth Bass
- 0x3F: Drums
- 0x40 bit: Additional Change
    - 0x00-0x0F: (Amp Envelope: 0x00-0x0F)
    - 0x10 bit: Vibrato On
    - 0x20 bit: Layer On (Ch #1 Sync)

## Drum Map

- Note #35 (0x23): Bass Drum 1
- Note #38 (0x26): Snare Drum 1
- Note #42 (0x2A): Closed Hi-Hat
- Note #46 (0x2E): Open Hi-Hat

## Amp Envelope

- 0x00: Lead
- 0x01: Organ
- 0x02: Brass
- 0x03: Strings
- 0x04: Pad
- 0x05: Bass (Guiter)
- 0x06: Piano
- 0x07: Koto
- 0x0F: Silence
- 0x10: Bass Drum 1
- 0x11: Snare Drum 1
- 0x12: Closed Hi-Hat
- 0x13: Open Hi-Hat

## Waveform

- 0x00: Saw
- 0x01: Pulse 6.25%
- 0x02: Pulse 12.5%
- 0x03: Pulse 18.75%
- 0x04: Pulse 25%
- 0x05: Pulse 31.25%
- 0x06: Pulse 37.5%
- 0x07: Pulse 43.75%
- 0x08: Square (Pulse 50%)
- 0x09: Triangle
- 0x1E: Noise
- 0x1F: Silence

## MIDI Implementation Chart [TODO]

- CC #7: Channel Volume
- CC #120: All Sound Off
- CC #121: Reset All Controllers
- CC #123: All Notes Off
