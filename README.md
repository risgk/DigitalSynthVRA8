# ISGK VRA8 Digital Synthesizer V0.xx

2014-08-26 risgk

## Concept

- 8-bit Virtual Analog (Monophonic) Synthesizer

## VRA8 Features

- Arduino Uno, Serial MIDI, PWM Audio, Buzzer
- Audio Rate: 31250 Hz, Bit Depth: 8 bits

## VRA8.RB Features

- Simulator of VRA8
- Software Synthesizer for Windows
- Using Ruby (JRuby, UniMIDI, win32-sound)

## Synthesizer Modules

- VCO1
    - Waveform: Saw, Square, Triangle
- VCO2
    - Waveform: Saw, Square, Triangle
    - Coarse Tune: -64, ..., +63 (semitone)
    - Fine Tune: -10, 0, +10 (cent)
- VCO3
    - Waveform: Saw, Square, Triangle
    - Coarse Tune: -64, ..., +63 (semitone)
    - Fine Tune: -10, 0, +10 (cent)
- VCF
    - Cutoff: Audio Rate / 16, ..., Audio Rate / 8, ..., Audio Rate / 4
    - Resonance: OFF (Q = 0.7071), ON (Q = 1.414)
    - Envelope: OFF, ON
- VCA
- EG
    - Attack: 8, ..., 131, ..., 2089 (ms)
    - Decay/Release: 8, ..., 131, ..., 2089 (ms)
    - Sustain: 0, ..., 64, ... 127

## Preset Programs

    +------+------------------+
    | PC # | Program Name     |
    +------+------------------+
    |    0 | Sub Osc Lead     |
    |    1 | Saw Lead         |
    |    2 | Square Lead      |
    |    3 | Synth Pad        |
    |    4 | Synth Bass       |
    +------+------------------+

## MIDI Implementation Chart

      Digital Synthesizer                                             Date: 2014-xx-xx
      Model: VRA8                     MIDI Implementation Chart       Version: 0.xx
    +-------------------------------+---------------+---------------+-------------------+
    | Function                      | Transmitted   | Recognized    | Remarks           |
    +-------------------------------+---------------+---------------+-------------------+
    | Basic        Default          | x             | 1             |                   |
    | Channel      Changed          | x             | 1             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Mode         Default          | x             | Mode 4        |                   |
    |              Messages         | x             | x             |                   |
    |              Altered          | ************* |               |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Note                          | x             | 0-127         |                   |
    | Number       : True Voice     | ************* | 24-96         |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Velocity     Note On          | x             | x  *1         |                   |
    |              Note Off         | x             | x  *2         |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | After        Key's            | x             | x             |                   |
    | Touch        Channel's        | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Pitch Bend                    | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Control                    40 | x             | o             | VCO1 Waveform     |
    | Change                     41 | x             | o             | VCO1 Coarse Tune  |
    |                            42 | x             | o             | VCO2 Waveform     |
    |                            43 | x             | o             | VCO2 Coarse Tune  |
    |                            44 | x             | o             | VCO2 Fine Tune    |
    |                            45 | x             | o             | VCO3 Waveform     |
    |                            46 | x             | o             | VCO3 Coarse Tune  |
    |                            47 | x             | o             | VCO3 Fine Tune    |
    |                            48 | x             | o             | VCF Cutoff        |
    |                            49 | x             | o             | VCF Resonance     |
    |                            50 | x             | o             | VCF Envelope      |
    |                            51 | x             | o             | EG Attack         |
    |                            52 | x             | o             | EG Decay/Release  |
    |                            53 | x             | o             | EG Sustain        |
    +-------------------------------+---------------+---------------+-------------------+
    | Program                       | x             | o             |                   |
    | Change       : True Number    | ************* | 0-4           |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | System Exclusive              | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | System       : Song Position  | x             | x             |                   |
    | Common       : Song Select    | x             | x             |                   |
    |              : Tune Request   | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | System       : Clock          | x             | x             |                   |
    | Real Time    : Commands       | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Aux          : Local On/Off   | x             | x             |                   |
    | Messages     : All Notes Off  | x             | o             |                   |
    |              : Active Sensing | x             | x             |                   |
    |              : System Reset   | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Notes                         | *1  9nH v=1-127                                   |
    |                               | *2  9nH v=0 or 8nH v=0-127                        |
    +-------------------------------+---------------------------------------------------+
      Mode 1: Omni On,  Poly          Mode 2: Omni On,  Mono          o: Yes
      Mode 3: Omni Off, Poly          Mode 4: Omni Off, Mono          x: No
