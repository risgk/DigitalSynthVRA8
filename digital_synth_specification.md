# Digital Synth (Tentative) Specification

2014-07-21 risgk

## Keywords

- Digital synthesizer, 8-bit sound, virtual analog sound
- Arduino Uno, piezo buzzer (or audio jack)
- Ruby programming language (for MIDI controller)

## Sound Quality

- PWM rate = 62500 Hz
- Audio rate = 31250 Hz
- Bit depth = 8 bits

## Synth Modules

- UART In (MIDI In)
- Ctrl
- LFO * 4
- Osc * 4
- EG * 4
- Amp * 4
- Mixer
- Filter (LPF)
- DAC (PWM Out)

## Initial Settings

- Mode 4 (Omni Off, Mono)
- Ch #1 (0x00) = Saw Lead
- Ch #2 (0x01) = Square Lead
- Ch #3 (0x02) = Triangle Lead
- Ch #4 (0x03) = Drums
- Ch #10 = Treated as Ch #4
- Channel Volume = 0x7F
- Channel Fine Tuning = 0x40
- Channel Coarse Tuning = 0x40

## Program Change

- 0x00-0x6F = (waveform (0x00-0x0D) * 8) + envelope (0x00-0x07)
- 0x70 = VA Saw Lead
- 0x71 = VA Mixed Lead
- 0x72 = VA Synth Brass
- 0x73 = VA Synth Bass
- 0x74 = [Reserved]
- 0x75 = [Reserved]
- 0x76 = [Reserved]
- 0x77 = Drums
- 0x78 = Vibrato OFF
- 0x79 = Vibrato ON
- 0x7A = Detune OFF
- 0x7B = Detune ON
- 0x7C = Sync OFF
- 0x7D = Sync ON
- 0x7E = [Reserved]
- 0x7F = [Reserved]

## Drum Map

- Note #35 (0x23) = Bass Drum 1
- Note #38 (0x26) = Snare Drum 1
- Note #42 (0x2A) = Closed Hi-Hat
- Note #46 (0x2E) = Open Hi-Hat

## Envelope (Amp)

- 0x00 = Organ
- 0x01 = Lead
- 0x02 = Brass
- 0x03 = Strings
- 0x04 = Pad
- 0x05 = Bass (Guiter)
- 0x06 = Piano
- 0x07 = Koto
- 0x08 = Bass Drum 1
- 0x09 = Snare Drum 1
- 0x0A = Closed Hi-Hat
- 0x0B = Open Hi-Hat

## Waveform

- 0x00 = Saw
- 0x01 = Pulse 6.25%
- 0x02 = Pulse 12.5%
- 0x03 = Pulse 18.75%
- 0x04 = Pulse 25%
- 0x05 = Pulse 31.25%
- 0x06 = Pulse 37.5%
- 0x07 = Pulse 43.75%
- 0x08 = Square (Pulse 50%)
- 0x09 = Triangle
- 0x0A = Noise
- 0x0B = [Reserved]
- 0x0C = [Reserved]
- 0x0D = [Reserved]

## MIDI Implementation Chart [TODO]

- CC #7 = Channel Volume
- CC #120 = All Sound Off
- CC #121 = Reset All Controllers
- CC #123 = All Notes Off
