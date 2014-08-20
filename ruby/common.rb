PROGRAM_TOGGLE_NOTE_NUMBER = 61  # 255
MIDI_TRUE_CH               = 0

AUDIO_RATE      = 31250
NOTE_NUMBER_MIN = 12
NOTE_NUMBER_MAX = 108

WAVEFORM_SAW      = 0
WAVEFORM_SQUARE   = 1
WAVEFORM_TRIANGLE = 2

MIDI_DATA_BYTE_MAX        = 0x7F
MIDI_NOTE_ON              = (0x90 | MIDI_TRUE_CH)  # 2 data bytes
MIDI_NOTE_OFF             = (0x80 | MIDI_TRUE_CH)  # 2 data bytes
MIDI_CONTROL_CHANGE       = (0xB0 | MIDI_TRUE_CH)  # 2 data bytes
MIDI_PROGRAM_CHANGE       = (0xC0 | MIDI_TRUE_CH)  # 1 data byte
MIDI_SYSTEM_MIN           = 0xF0
MIDI_SYSTEM_EXCLUSIVE     = 0xF0
MIDI_SYSTEM_TIME_CODE     = 0xF1                   # 1 data byte
MIDI_SYSTEM_SONG_POSITION = 0xF2                   # 2 data bytes
MIDI_SYSTEM_SONG_SELECT   = 0xF3                   # 1 data byte
MIDI_SYSTEM_TUNE_REQUEST  = 0xF6
MIDI_SYSTEM_EOX           = 0xF7
MIDI_REAL_TIME_MIN        = 0xF8                   # 1 data byte
MIDI_ACTIVE_SENSING       = 0xFE                   # 1 data byte

CC_OSC1_WAVEFORM    = 40
CC_OSC2_WAVEFORM    = 41
CC_OSC2_COARSE_TUNE = 42
CC_OSC2_FINE_TUNE   = 43
CC_OSC3_WAVEFORM    = 44
CC_OSC3_COARSE_TUNE = 45
CC_OSC3_FINE_TUNE   = 46
CC_FILTER_CUTOFF    = 47
CC_FILTER_RESONANCE = 48
CC_FILTER_ENVELOPE  = 49
CC_EG_ATTACK        = 50
CC_EG_DECAY_RELEASE = 51
CC_EG_SUSTAIN       = 52

PC_SUB_OSC_LEAD    = 0
PC_SAW_LEAD        = 1
PC_SQUERE_LEAD     = 2
PC_SYNTH_PAD       = 3
PC_SYNTH_BASS      = 4
PC_TRUE_NUMBER_MAX = 4

def high_byte(ui16)
  ui16 >> 8
end

def low_byte(ui16)
  ui16 & 0xFF
end
