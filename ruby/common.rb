PROGRAM_TOGGLE_NOTE_NUMBER = 61  # 255
CH                         = 0

AUDIO_RATE      = 31250
NOTE_NUMBER_MIN = 24
NOTE_NUMBER_MAX = 108

SUB_OSC_LEAD       = 0
SAW_LEAD           = 1
SQUERE_LEAD        = 2
SYNTH_PAD          = 3
SYNTH_BASS         = 4
PROGRAM_NUMBER_MAX = 4

SAW      = 0
SQUARE   = 1
TRIANGLE = 2

ON       = 127
OFF      = 0

DATA_BYTE_MAX        = 0x7F
NOTE_ON              = (0x90 | CH)  # 2 data bytes
NOTE_OFF             = (0x80 | CH)  # 2 data bytes
CONTROL_CHANGE       = (0xB0 | CH)  # 2 data bytes
PROGRAM_CHANGE       = (0xC0 | CH)  # 1 data byte
SYSTEM_MIN           = 0xF0
SYSTEM_EXCLUSIVE     = 0xF0
SYSTEM_TIME_CODE     = 0xF1         # 1 data byte
SYSTEM_SONG_POSITION = 0xF2         # 2 data bytes
SYSTEM_SONG_SELECT   = 0xF3         # 1 data byte
SYSTEM_TUNE_REQUEST  = 0xF6
SYSTEM_EOX           = 0xF7
REAL_TIME_MIN        = 0xF8         # 1 data byte
ACTIVE_SENSING       = 0xFE         # 1 data byte

VCO1_WAVEFORM    = 40
VCO2_WAVEFORM    = 41
VCO2_COARSE_TUNE = 42
VCO2_FINE_TUNE   = 43
VCO3_WAVEFORM    = 44
VCO3_COARSE_TUNE = 45
VCO3_FINE_TUNE   = 46
VCF_CUTOFF       = 47
VCF_RESONANCE    = 48
VCF_ENVELOPE     = 49
EG_ATTACK        = 50
EG_DECAY_RELEASE = 51
EG_SUSTAIN       = 52

def high_byte(ui16)
  ui16 >> 8
end

def low_byte(ui16)
  ui16 & 0xFF
end
