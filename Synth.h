#pragma once

#include "Common.h"
#include "ProgramTable.h"
#include "VCO.h"
#include "VCF.h"
#include "VCA.h"
#include "EG.h"
#include "Mixer.h"

class Synth
{
  static uint8_t m_systemExclusive;
  static uint8_t m_systemDataRemaining;
  static uint8_t m_runningStatus;
  static uint8_t m_firstData;
  static uint8_t m_noteNumber;

public:
  static void initialize()
  {
    programChange(0);
  }

  static void receiveMIDIByte(uint8_t b)
  {
    if (IsDataByte(b)) {
      if (m_systemExclusive) {
        // do nothing
      } else if (m_systemDataRemaining != (uint8_t) 0) {
        m_systemDataRemaining--;
      } else if (m_runningStatus == (NOTE_ON | MIDI_CH)) {
        if (!IsDataByte(m_firstData)) {
          m_firstData = b;
        } else if (b == (uint8_t) 0) {
          noteOff(m_firstData);
          m_firstData = DATA_BYTE_INVALID;
        } else {
          noteOn(m_firstData);
          m_firstData = DATA_BYTE_INVALID;
        }
      } else if (m_runningStatus == (NOTE_OFF | MIDI_CH)) {
        if (!IsDataByte(m_firstData)) {
          m_firstData = b;
        } else {
          noteOff(m_firstData);
          m_firstData = DATA_BYTE_INVALID;
        }
      } else if (m_runningStatus == (PROGRAM_CHANGE | MIDI_CH)) {
        programChange(b);
      } else if (m_runningStatus == (CONTROL_CHANGE | MIDI_CH)) {
        if (!IsDataByte(m_firstData)) {
          m_firstData = b;
        } else {
          controlChange(m_firstData, b);
          m_firstData = DATA_BYTE_INVALID;
        }
      }
    } else if (IsSystemMessage(b)) {
      switch (b) {
      case SYSTEM_EXCLUSIVE:
        m_systemExclusive = true;
        m_runningStatus = STATUS_BYTE_INVALID;
        break;
      case EOX:
      case TUNE_REQUEST:
      case 0xF4:
      case 0xF5:
        m_systemExclusive = false;
        m_systemDataRemaining = 0;
        m_runningStatus = STATUS_BYTE_INVALID;
        break;
      case TIME_CODE:
      case SONG_SELECT:
        m_systemExclusive = false;
        m_systemDataRemaining = 1;
        m_runningStatus = STATUS_BYTE_INVALID;
        break;
      case SONG_POSITION:
        m_systemExclusive = false;
        m_systemDataRemaining = 2;
        m_runningStatus = STATUS_BYTE_INVALID;
        break;
      }
    } else if (IsStatusByte(b)) {
      m_systemExclusive = false;
      m_runningStatus = b;
      m_firstData = DATA_BYTE_INVALID;
    }
  }

  static int8_t clock()
  {
    int8_t level = Mixer::clock(VCO<1>::clock(), VCO<2>::clock(), VCO<3>::clock());
    uint8_t egOutput = EG::clock();
    level = VCF::clock(level, egOutput);
    level = VCA::clock(level, egOutput);
    return level;
  }

  static boolean IsRealTimeMessage(uint8_t b)
  {
    return b >= REAL_TIME_MESSAGE_MIN;
  }

  static boolean IsSystemMessage(uint8_t b)
  {
    return b >= SYSTEM_MESSAGE_MIN;
  }

  static boolean IsStatusByte(uint8_t b)
  {
    return b >= STATUS_BYTE_MIN;
  }

  static boolean IsDataByte(uint8_t b)
  {
    return b <= DATA_BYTE_MAX;
  }

  static void noteOn(uint8_t noteNumber)
  {
#ifdef OPTION_BLACK_KEY_PROGRAM_CHANGE
    if (noteNumber > 96) {
      switch (noteNumber) {
      case 97:  // C#7
        programChange(0);
        return;
      case 99:  // D#7
        programChange(1);
        return;
      case 102:  // F#7
        programChange(2);
        return;
      case 104:  // G#7
        programChange(3);
        return;
      case 106:  // A#7
        programChange(4);
        return;
      }
    }
#endif

    uint8_t pitch1 = noteNumber + VCO<1>::coarseTune();
    if (pitch1 < (uint8_t) (NOTE_NUMBER_MIN + (uint8_t) 64) ||
        pitch1 > (uint8_t) (NOTE_NUMBER_MAX + (uint8_t) 64)) {
      return;
    }

    uint8_t pitch2 = noteNumber + VCO<2>::coarseTune();
    if (pitch2 < (uint8_t) (NOTE_NUMBER_MIN + (uint8_t) 64) ||
        pitch2 > (uint8_t) (NOTE_NUMBER_MAX + (uint8_t) 64)) {
      return;
    }

    uint8_t pitch3 = noteNumber + VCO<3>::coarseTune();
    if (pitch3 < (uint8_t) (NOTE_NUMBER_MIN + (uint8_t) 64) ||
        pitch3 > (uint8_t) (NOTE_NUMBER_MAX + (uint8_t) 64)) {
      return;
    }

    m_noteNumber = noteNumber;
    VCO<1>::noteOn(m_noteNumber);
    VCO<2>::noteOn(m_noteNumber);
    VCO<3>::noteOn(m_noteNumber);
    EG::noteOn();
  }

  static void noteOff(uint8_t noteNumber)
  {
    if (noteNumber == m_noteNumber) {
      EG::noteOff();
    }
  }

  static void soundOff()
  {
    EG::soundOff();
  }

  static void resetPhase()
  {
    VCO<1>::resetPhase();
    VCO<2>::resetPhase();
    VCO<3>::resetPhase();
  }

  static void controlChange(uint8_t controllerNumber, uint8_t value)
  {
    switch (controllerNumber) {
    case ALL_NOTES_OFF:
      allNotesOff(value);
      break;
    case VCO_1_WAVEFORM:
      setVCO1Waveform(value);
      break;
    case VCO_1_COARSE_TUNE:
      setVCO1CoarseTune(value);
      break;
    case VCO_2_WAVEFORM:
      setVCO2Waveform(value);
      break;
    case VCO_2_COARSE_TUNE:
      setVCO2CoarseTune(value);
      break;
    case VCO_2_FINE_TUNE:
      setVCO2FineTune(value);
      break;
    case VCO_3_WAVEFORM:
      setVCO3Waveform(value);
      break;
    case VCO_3_COARSE_TUNE:
      setVCO3CoarseTune(value);
      break;
    case VCO_3_FINE_TUNE:
      setVCO3FineTune(value);
      break;
    case VCF_CUTOFF_FREQUENCY:
      setVCFCutoffFrequency(value);
      break;
    case VCF_RESONANCE:
      setVCFResonance(value);
      break;
    case VCF_ENVELOPE_AMOUNT:
      setVCFEnvelopeAmount(value);
      break;
    case EG_ATTACK_TIME:
      setEGAttackTime(value);
      break;
    case EG_DECAY_TIME:
      setEGDecayTime(value);
      break;
    case EG_SUSTAIN_LEVEL:
      setEGSustainLevel(value);
      break;
    }
  }

  static void setVCO1Waveform(uint8_t value)
  {
    soundOff();
    VCO<1>::setWaveform(value);
    resetPhase();
  }

  static void setVCO1CoarseTune(uint8_t value)
  {
    soundOff();
    VCO<1>::setCoarseTune(value);
    resetPhase();
  }

  static void setVCO2Waveform(uint8_t value)
  {
    soundOff();
    VCO<2>::setWaveform(value);
    resetPhase();
  }

  static void setVCO2CoarseTune(uint8_t value)
  {
    soundOff();
    VCO<2>::setCoarseTune(value);
    resetPhase();
  }

  static void setVCO2FineTune(uint8_t value)
  {
    soundOff();
    VCO<2>::setFineTune(value);
    resetPhase();
  }

  static void setVCO3Waveform(uint8_t value)
  {
    soundOff();
    VCO<3>::setWaveform(value);
    resetPhase();
  }

  static void setVCO3CoarseTune(uint8_t value)
  {
    soundOff();
    VCO<3>::setCoarseTune(value);
    resetPhase();
  }

  static void setVCO3FineTune(uint8_t value)
  {
    soundOff();
    VCO<3>::setFineTune(value);
    resetPhase();
  }

  static void setVCFCutoffFrequency(uint8_t value)
  {
    VCF::setCutoffFrequency(value);
  }

  static void setVCFResonance(uint8_t value)
  {
    VCF::setResonance(value);
  }

  static void setVCFEnvelopeAmount(uint8_t value)
  {
    VCF::setEnvelopeAmount(value);
  }

  static void setEGAttackTime(uint8_t value)
  {
    EG::setAttackTime(value);
  }

  static void setEGDecayTime(uint8_t value)
  {
    EG::setDecayTime(value);
  }

  static void setEGSustainLevel(uint8_t value)
  {
    EG::setSustainLevel(value);
  }

  static void allNotesOff(uint8_t value)
  {
    EG::noteOff();
  }

  static void programChange(uint8_t programNumber)
  {
    soundOff();
    const uint8_t* p = g_programTable + (uint16_t) (programNumber * PROGRAM_SIZE);
    VCO<1>::setWaveform(*p++);
    VCO<1>::setCoarseTune(*p++);
    VCO<2>::setWaveform(*p++);
    VCO<2>::setCoarseTune(*p++);
    VCO<2>::setFineTune(*p++);
    VCO<3>::setWaveform(*p++);
    VCO<3>::setCoarseTune(*p++);
    VCO<3>::setFineTune(*p++);
    VCF::setCutoffFrequency(*p++);
    VCF::setResonance(*p++);
    VCF::setEnvelopeAmount(*p++);
    EG::setAttackTime(*p++);
    EG::setDecayTime(*p++);
    EG::setSustainLevel(*p++);
    resetPhase();
  }
};

uint8_t Synth::m_systemExclusive     = false;
uint8_t Synth::m_systemDataRemaining = 0;
uint8_t Synth::m_runningStatus       = STATUS_BYTE_INVALID;
uint8_t Synth::m_firstData           = DATA_BYTE_INVALID;
uint8_t Synth::m_noteNumber          = 60;
