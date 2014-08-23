# ISGK VRA8 Digital Synthesizer V0.xx

2014-08-23 risgk

## Concept

- 8-bit Virtual Analog Monophonic Synthesizer

## VRA8 Features

- Arduino Uno, Serial MIDI, PWM Audio, Buzzer
- Audio Rate: 31250 Hz
- Bit Depth: 8 bits

## VRA8.rb Features

- Simulator of VRA8
- Software Synthesizer for Windows
- Using Ruby (JRuby, win32-sound, UniMIDI)

## Synthesizer Modules

- VCO1
    - WAVEFORM: SAW, SQUARE, TRIANGLE
- VCO2
    - WAVEFORM: SAW, SQUARE, TRIANGLE
    - COARSE TUNE: -64, ..., +63 (semitone)
    - FINE TUNE: -10, 0, +10 (cent)
- VCO3
    - WAVEFORM: SAW, SQUARE, TRIANGLE
    - COARSE TUNE: -64, ..., +63 (semitone)
    - FINE TUNE: -10, 0, +10 (cent)
- VCF
    - CUTOFF: Audio Rate / 16, ..., Audio Rate / 8, ..., Audio Rate / 4
    - RESONANCE: OFF (Q = 0.7071), ON (Q = 1.414)
    - ENVELOPE: OFF, ON
- VCA
- EG
    - ATTACK: 8, ..., 131, ..., 2089 (ms)
    - DECAY/RELEASE: 8, ..., 131, ..., 2089 (ms)
    - SUSTAIN: 0, ..., 64, ... 127

## Preset Programs

    +------+------------------+
    | PC # | Program Name     |
    +------+------------------+
    |    0 | SUB VCO LEAD     |
    |    1 | SAW LEAD         |
    |    2 | SQUARE LEAD      |
    |    3 | SYNTH PAD        |
    |    4 | SYNTH BASS       |
    +------+------------------+

## MIDI Implementation Chart

      Digital Synthesizer                                             Date: 2014-xx-xx
      Model: VRA8                     MIDI Implementation Chart       Version: 0.xx
    +-------------------------------+---------------+---------------+-------------------+
    | Function...                   | Transmitted   | Recognized    | Remarks           |
    +-------------------------------+---------------+---------------+-------------------+
    | Basic        Default          | x             | 1             |                   |
    | Channel      Changed          | x             | 1             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Mode         Default          | x             | Mode 4        |                   |
    |              Messages         | x             | x             |                   |
    |              Altered          | ************* |               |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Note                          | x             | 12-108        |                   |
    | Number       : True Voice     | ************* | 12-108        |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Velocity     Note On          | x             | x  *1         |                   |
    |              Note Off         | x             | x  *2         |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | After        Key's            | x             | x             |                   |
    | Touch        Channel's        | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Pitch Bend                    | x             | x             |                   |
    +-------------------------------+---------------+---------------+-------------------+
    | Control                    40 | x             | o             | VCO1 WAVEFORM     |
    | Change                     41 | x             | o             | VCO2 WAVEFORM     |
    |                            42 | x             | o             | VCO2 COARSE TUNE  |
    |                            43 | x             | o             | VCO2 FINE TUNE    |
    |                            44 | x             | o             | VCO3 WAVEFORM     |
    |                            45 | x             | o             | VCO3 COARSE TUNE  |
    |                            46 | x             | o             | VCO3 FINE TUNE    |
    |                            47 | x             | o             | VCF CUTOFF        |
    |                            48 | x             | o             | VCF RESONANCE     |
    |                            49 | x             | o             | VCF ENVELOPE      |
    |                            50 | x             | o             | EG ATTACK         |
    |                            51 | x             | o             | EG DECAY/RELEASE  |
    |                            52 | x             | o             | EG SUSTAIN        |
    +-------------------------------+---------------+---------------+-------------------+
    | Program                       | x             | o             |                   |
    | Change       : True #         | ************* | 0-4           |                   |
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
