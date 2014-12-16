#pragma once

#define OPTION_BLACK_KEY_PROGRAM_CHANGE
//#define OPTION_DEMO_MODE
#define OPTION_OVERLOAD_LED

//const uint16_t SERIAL_SPEED       = 31250;
const uint16_t SERIAL_SPEED       = 38400;
const uint8_t  MIDI_CH            = 0;
const uint16_t SAMPLING_RATE      = 15625;
const uint8_t  NOTE_NUMBER_MIN    = 24;
const uint8_t  NOTE_NUMBER_MAX    = 96;
const uint8_t  EG_UPDATE_INTERVAL = 25;

const uint8_t PROGRAM_SIZE = 16;
const uint8_t SUB_OSC_LEAD = 0;
const uint8_t SAW_LEAD     = 1;
const uint8_t SQUERE_LEAD  = 2;
const uint8_t SYNTH_PAD    = 3;
const uint8_t SYNTH_BASS   = 4;

const uint8_t SAWTOOTH   = 0;
const uint8_t SQUARE     = 1;
const uint8_t TRIANGLE   = 2;
const uint8_t SINE       = 3;
const uint8_t PULSE_25   = 4;
const uint8_t PULSE_12   = 5;
const uint8_t PSEUDO_TRI = 6;

const uint8_t ON  = 127;
const uint8_t OFF = 0;

const uint8_t DATA_BYTE_MAX         = 0x7F;
const uint8_t STATUS_BYTE_INVALID   = 0x7F;
const uint8_t DATA_BYTE_INVALID     = 0x80;
const uint8_t STATUS_BYTE_MIN       = 0x80;
const uint8_t NOTE_OFF              = 0x80;
const uint8_t NOTE_ON               = 0x90;
const uint8_t CONTROL_CHANGE        = 0xB0;
const uint8_t PROGRAM_CHANGE        = 0xC0;
const uint8_t SYSTEM_MESSAGE_MIN    = 0xF0;
const uint8_t SYSTEM_EXCLUSIVE      = 0xF0;
const uint8_t TIME_CODE             = 0xF1;
const uint8_t SONG_POSITION         = 0xF2;
const uint8_t SONG_SELECT           = 0xF3;
const uint8_t TUNE_REQUEST          = 0xF6;
const uint8_t EOX                   = 0xF7;
const uint8_t REAL_TIME_MESSAGE_MIN = 0xF8;
const uint8_t ACTIVE_SENSING        = 0xFE;

const uint8_t VCO_1_WAVEFORM        = 14;
const uint8_t VCO_1_COARSE_TUNE     = 15;
const uint8_t VCO_2_WAVEFORM        = 16;
const uint8_t VCO_2_COARSE_TUNE     = 17;
const uint8_t VCO_2_FINE_TUNE       = 18;
const uint8_t VCO_3_WAVEFORM        = 19;
const uint8_t VCO_3_COARSE_TUNE     = 20;
const uint8_t VCO_3_FINE_TUNE       = 21;
const uint8_t VCF_CUTOFF_FREQUENCY  = 22;
const uint8_t VCF_RESONANCE         = 23;
const uint8_t VCF_ENVELOPE_AMOUNT   = 24;
const uint8_t EG_ATTACK_TIME        = 25;
const uint8_t EG_DECAY_TIME         = 26;
const uint8_t EG_SUSTAIN_LEVEL      = 27;
const uint8_t ALL_NOTES_OFF         = 123;
