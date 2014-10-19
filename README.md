# Digital Synth VRA8 1.0.1

2014-10-19 ISGK Instruments  
[https://github.com/risgk/DigitalSynthVRA8](https://github.com/risgk/DigitalSynthVRA8)

## What's New

- v1.0.1: Fix the unit of Fine Tune, Fix MIDI Implementation Chart
- v1.0.0: Introduce Semantic Versioning
- V0.23: Add VRA8 CTRL Software Keyboard
- V0.22: Add a workaround: midi-jruby (0.0.12) cannot receive a data byte 2 with a value of 0
- V0.21: VRA8 CTRL supports Google Chrome 39 API
- V0.20: VRA8 CTRL is released

## Concept

- 8-bit Virtual Analog (Monophonic) Synthesizer
- No Keyboard, MIDI Sound Module
- For Arduino Uno

## VRA8 Features

- Sketch for Arduino Uno
- Serial MIDI In (38400 bps), PWM Audio Out (Pin 6), PWM Rate: 62500 Hz
- Sampling Rate: 15625 Hz, Bit Depth: 8 bits
- Recommending [Hairless MIDI<->Serial Bridge](http://projectgus.github.io/hairless-midiserial/) to connect PC
- Files
    - "DigitalSynthVRA8.ino" for Arduino Uno
    - "MakeSampleWavFile.cc" for Debugging on PC, makes a sample WAV file

## VRA8.rb Features

- Simulator of VRA8, Software Synthesizer for Windows
- Sampling Rate: 15625 Hz, Bit Depth: 8 bits
- Using Ruby (JRuby), UniMIDI, and win32-sound
    - `jgem install unimidi`
    - `jgem install win32-sound`
- Usage
    - `jruby vra8.rb` starts VRA8.rb
    - `jruby vra8.rb sample_midi_stream.bin` makes a sample WAV file
- Known Issues
    - VRA8.rb uses the full power of 2 CPU cores...

## VRA8 CTRL Features

- Parameter Editor (MIDI Controller) for VRA8, HTML5 App
- Please enable Web MIDI API of Google Chrome
    - `chrome://flags/#enable-web-midi`
- Recommending [loopMIDI](http://www.tobias-erichsen.de/software/loopmidi.html) (virtual loopback MIDI cable) to connect VRA8

## Synth Modules

- VCO 1
    - Waveform: Sawtooth(0), Square(1), Triangle(2)
    - Coarse Tune: -64(0), ..., 0(64), ..., +63(127) [semitone]
- VCO 2
    - Waveform: Sawtooth(0), Square(1), Triangle(2)
    - Coarse Tune: -64(0), ..., 0(64), ..., +63(127) [semitone]
    - Fine Tune: -10(51), 0(64), +10(77) [cent]
- VCO 3
    - Waveform: Sawtooth(0), Square(1), Triangle(2)
    - Coarse Tune: -64(0), ..., 0(64), ..., +63(127) [semitone]
    - Fine Tune: -10(51), 0(64), +10(77) [cent]
- VCF
    - Filter Type: LPF, Attenuation Slope: -12 [dB/oct]
    - Cutoff Frequency: 977(0), ..., 1953(64), ..., 3906(127) [Hz]
    - Resonance: Off(0), On(127)
    - Envelope Amount: 0(0), ..., 50(64), ..., 100(127) [%]
- VCA
- EG
    - Attack Time: 16(0), ..., 262(64), ..., 4178(127) [ms]
    - Decay Time: 16(0), ..., 262(64), ..., 4178(127) [ms]
    - Sustain Level: 0(0), ..., 50(64), ..., 100(127) [%]

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

      ISGK Instruments                                                Date: 2014-10-19       
      Model: Digital Synth VRA8       MIDI Implementation Chart       Version: 1.0.1         
    +-------------------------------+---------------+---------------+-----------------------+
    | Function                      | Transmitted   | Recognized    | Remarks               |
    +-------------------------------+---------------+---------------+-----------------------+
    | Basic        Default          | x             | 1             |                       |
    | Channel      Changed          | x             | x             |                       |
    +-------------------------------+---------------+---------------+-----------------------+
    | Mode         Default          | x             | Mode 4 (M=1)  |                       |
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
    |                            48 | x             | o             | VCF Cutoff Frequency  |
    |                            49 | x             | o             | VCF Resonance         |
    |                            50 | x             | o             | VCF Envelope Amount   |
    |                            51 | x             | o             | EG Attack Time        |
    |                            52 | x             | o             | EG Decay Time         |
    |                            53 | x             | o             | EG Sustain Level      |
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
