#pragma once

const boolean OPTION_BLACK_KEY_PROGRAM_CHANGE = true;
const boolean OPTION_DEMO_MODE_ENABLED        = true;

#if 1
const uint16_t SERIAL_SPEED = 38400;
#else
const uint16_t SERIAL_SPEED = 31250;
#endif
const uint8_t  MIDI_CH = 0;
const uint16_t SAMPLING_RATE = 15625;
const uint8_t  NOTE_NUMBER_MIN = 24;
const uint8_t  NOTE_NUMBER_MAX = 96;

const uint8_t PROGRAM_SIZE = 14;
const uint8_t SUB_OSC_LEAD = 0;
const uint8_t SAW_LEAD     = 1;
const uint8_t SQUERE_LEAD  = 2;
const uint8_t SYNTH_PAD    = 3;
const uint8_t SYNTH_BASS   = 4;

const uint8_t SAWTOOTH = 0;
const uint8_t SQUARE   = 1;
const uint8_t TRIANGLE = 2;

const uint8_t ON  = 127;
const uint8_t OFF = 0;

const uint8_t DATA_BYTE_MAX         = 0x7F;
const uint8_t DATA_BYTE_INVALID     = 0x80;
const uint8_t STATUS_BYTE_INVALID   = 0x7F;
const uint8_t STATUS_BYTE_MIN       = 0x80;
const uint8_t NOTE_ON               = (0x90 | MIDI_CH);
const uint8_t NOTE_OFF              = (0x80 | MIDI_CH);
const uint8_t CONTROL_CHANGE        = (0xB0 | MIDI_CH);
const uint8_t PROGRAM_CHANGE        = (0xC0 | MIDI_CH);
const uint8_t SYSTEM_MESSAGE_MIN    = 0xF0;
const uint8_t SYSTEM_EXCLUSIVE      = 0xF0;
const uint8_t TIME_CODE             = 0xF1;
const uint8_t SONG_POSITION         = 0xF2;
const uint8_t SONG_SELECT           = 0xF3;
const uint8_t EOX                   = 0xF7;
const uint8_t REAL_TIME_MESSAGE_MIN = 0xF8;
const uint8_t ACTIVE_SENSING        = 0xFE;

const uint8_t VCO_1_WAVEFORM        = 40;
const uint8_t VCO_1_COARSE_TUNE     = 41;
const uint8_t VCO_2_WAVEFORM        = 42;
const uint8_t VCO_2_COARSE_TUNE     = 43;
const uint8_t VCO_2_FINE_TUNE       = 44;
const uint8_t VCO_3_WAVEFORM        = 45;
const uint8_t VCO_3_COARSE_TUNE     = 46;
const uint8_t VCO_3_FINE_TUNE       = 47;
const uint8_t VCF_CUTOFF            = 48;
const uint8_t VCF_RESONANCE         = 49;
const uint8_t VCF_ENVELOPE          = 50;
const uint8_t EG_ATTACK             = 51;
const uint8_t EG_DECAY_PLUS_RELEASE = 52;
const uint8_t EG_SUSTAIN            = 53;
const uint8_t ALL_NOTES_OFF         = 123;
