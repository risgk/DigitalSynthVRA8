# Digital Synthesizer VRA8 V0.xx

2014-09-03 ISGK

## Concept

- 8-bit Virtual Analog (Monophonic) Synthesizer

## VRA8 Features

- Arduino Uno, Serial MIDI (38400 bps), PWM Audio (Pin 9), Buzzer
- Sampling Rate: 31250 Hz, Bit Depth: 8 bits
- Recommending [Hairless MIDI<->Serial Bridge](http://projectgus.github.io/hairless-midiserial/) to connect PC

## VRA8.rb Features

- Simulator of VRA8
- Software Synthesizer for Windows
- Using Ruby (JRuby), UniMIDI, and win32-sound
    - `jgem install unimidi`
    - `jgem install win32-sound`

## Synthesizer Modules

- VCO 1
    - Waveform: Sawtooth, Square, Triangle, Sine
    - Coarse Tune: -64, ..., +63 [semitone]
- VCO 2
    - Waveform: Sawtooth, Square, Triangle, Sine
    - Coarse Tune: -64, ..., +63 [semitone]
    - Fine Tune: -10, 0, +10 [cent]
- VCO 3
    - Waveform: Sawtooth, Square, Triangle, Sine
    - Coarse Tune: -64, ..., +63 [semitone]
    - Fine Tune: -10, 0, +10 [cent]
- VCF
    - Cutoff: SR/16, ..., SR/8, ..., SR/4
    - Resonance: OFF, ON
    - Envelope: 0, ..., 127
- VCA
- EG
    - Attack: 8, ..., 131, ..., 2089 [ms]
    - Decay + Release: 8, ..., 131, ..., 2089 [ms]
    - Sustain: 0, ..., 127

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
    +-------------------------------+---------------+---------------+-----------------------+
    | Function                      | Transmitted   | Recognized    | Remarks               |
    +-------------------------------+---------------+---------------+-----------------------+
    | Basic        Default          | x             | 1             |                       |
    | Channel      Changed          | x             | 1             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Mode         Default          | x             | Mode 4        |                       |
    |              Messages         | x             | x             |                       |
    |              Altered          | ************* |               |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Note                          | x             | 0-127         |                       |
    | Number       : True Voice     | ************* | 24-96         |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Velocity     Note On          | x             | x  *1         |                       |
    |              Note Off         | x             | x  *2         |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | After        Key's            | x             | x             |                       |
    | Touch        Channel's        | x             | x             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Pitch Bend                    | x             | x             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Control                    40 | x             | o             | VCO 1 Waveform        |
    | Change                     41 | x             | o             | VCO 1 Coarse Tune     |
    |                            42 | x             | o             | VCO 2 Waveform        |
    |                            43 | x             | o             | VCO 2 Coarse Tune     |
    |                            44 | x             | o             | VCO 2 Fine Tune       |
    |                            45 | x             | o             | VCO 3 Waveform        |
    |                            46 | x             | o             | VCO 3 Coarse Tune     |
    |                            47 | x             | o             | VCO 3 Fine Tune       |
    |                            48 | x             | o             | VCF Cutoff            |
    |                            49 | x             | o             | VCF Resonance         |
    |                            50 | x             | o             | VCF Envelope          |
    |                            51 | x             | o             | EG Attack             |
    |                            52 | x             | o             | EG Decay + Release    |
    |                            53 | x             | o             | EG Sustain            |
    +-------------------------------+---------------+---------------+-----------------------+
    | Program                       | x             | o             |                       |
    | Change       : True Number    | ************* | 0-4           |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | System Exclusive              | x             | x             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | System       : Song Position  | x             | x             |                       |
    | Common       : Song Select    | x             | x             |                       |
    |              : Tune Request   | x             | x             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | System       : Clock          | x             | x             |                       |
    | Real Time    : Commands       | x             | x             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Aux          : Local On/Off   | x             | x             |                       |
    | Messages     : All Notes Off  | x             | o             |                       |
    |              : Active Sensing | x             | x             |                       |
    |              : System Reset   | x             | x             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Notes                         | *1  9nH v=1-127                                       |
    |                               | *2  9nH v=0 or 8nH v=0-127                            |
    +-------------------------------+-------------------------------------------------------+
      Mode 1: Omni On,  Poly          Mode 2: Omni On,  Mono          o: Yes                 
      Mode 3: Omni Off, Poly          Mode 4: Omni Off, Mono          x: No                  
