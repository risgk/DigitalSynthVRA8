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
  inline static void receiveMIDIByte(uint8_t b)
  {
    if (IsDataByte(b)) {
      if (m_systemExclusive) {
        // do nothing
      } else if (m_systemDataRemaining > 0) {
        m_systemDataRemaining--;
      } else if (m_runningStatus == NOTE_ON) {
        if (!IsDataByte(m_firstData)) {
          m_firstData = b;
        } else if (b == 0x00) {
          noteOff(m_firstData);
          m_firstData = DATA_BYTE_INVALID;
        } else {
          noteOn(m_firstData);
          m_firstData = DATA_BYTE_INVALID;
        }
      } else if (m_runningStatus == NOTE_OFF) {
        if (!IsDataByte(m_firstData)) {
          m_firstData = b;
        } else {
          noteOff(m_firstData);
          m_firstData = DATA_BYTE_INVALID;
        }
      } else if (m_runningStatus == PROGRAM_CHANGE) {
        programChange(b);
      } else if (m_runningStatus == CONTROL_CHANGE) {
        if (!IsDataByte(m_firstData)) {
          m_firstData = b;
        } else {
          controlChange(m_firstData, b);
          m_firstData = DATA_BYTE_INVALID;
        }
      }
    } else if (IsStatusByte(b)) {
      m_runningStatus = b;
      m_firstData = DATA_BYTE_INVALID;
    } else if (IsSystemMessage(b)) {
      switch (b) {
      case EOX:
        m_systemExclusive = false;
        m_systemDataRemaining = 0;
        break;
      case SONG_SELECT:
      case TIME_CODE:
        m_systemDataRemaining = 1;
        break;
      case SONG_POSITION:
        m_systemDataRemaining = 2;
        break;
      case SYSTEM_EXCLUSIVE:
        m_systemExclusive = true;
        break;
      }
    } else { // real_time_message
      // do nothing
    }
  }

  inline static int8_t clock()
  {
    int8_t level = Mixer::clock(VCO<1>::clock(), VCO<2>::clock(), VCO<3>::clock());
    uint8_t egOutput = EG::clock();
    level = VCF::clock(level, egOutput);
    level = VCA::clock(level, egOutput);
    return level;
  }

private:
  inline static boolean IsRealTimeMessage(uint8_t b)
  {
    return b >= REAL_TIME_MESSAGE_MIN;
  }

  inline static boolean IsSystemMessage(uint8_t b)
  {
    return b >= SYSTEM_MESSAGE_MIN;
  }

  inline static boolean IsStatusByte(uint8_t b)
  {
    return b >= STATUS_BYTE_MIN;
  }

  inline static boolean IsDataByte(uint8_t b)
  {
    return b <= DATA_BYTE_MAX;
  }

  inline static void noteOn(uint8_t noteNumber)
  {
    if (OPTION_BLACK_KEY_PROGRAM_CHANGE) {
      switch (noteNumber) {
      case 97:  // C#7
        programChange(0);
        break;
      case 99:  // D#7
        programChange(1);
        break;
      case 102:  // F#7
        programChange(2);
        break;
      case 104:  // G#7
        programChange(3);
        break;
      case 106:  // A#7
        programChange(4);
        break;
      }
    }

    uint8_t pitch2 = noteNumber + VCO<2>::coarseTune();
    if (pitch2 < (NOTE_NUMBER_MIN + 64) || pitch2 > (NOTE_NUMBER_MAX + 64)) {
      return;
    }

    uint8_t pitch3 = noteNumber + VCO<3>::coarseTune();
    if (pitch3 < (NOTE_NUMBER_MIN + 64) || pitch3 > (NOTE_NUMBER_MAX + 64)) {
      return;
    }

    m_noteNumber = noteNumber;
    VCO<1>::noteOn(m_noteNumber);
    VCO<2>::noteOn(m_noteNumber);
    VCO<3>::noteOn(m_noteNumber);
    EG::noteOn();
  }

  inline static void noteOff(uint8_t noteNumber)
  {
    if (noteNumber == m_noteNumber) {
      EG::noteOff();
    }
  }

  inline static void soundOff()
  {
    EG::soundOff();
  }

  inline static void resetPhase()
  {
    VCO<1>::resetPhase();
    VCO<2>::resetPhase();
    VCO<3>::resetPhase();
  }

  inline static void controlChange(uint8_t controller_number, uint8_t value)
  {
    switch (controller_number) {
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
      setVCO2_fine_tune(value);
      break;
    case VCO_3_WAVEFORM:
      setVCO3Waveform(value);
      break;
    case VCO_3_COARSE_TUNE:
      setVCO3CoarseTune(value);
      break;
    case VCO_3_FINE_TUNE:
      setVCO3_fine_tune(value);
      break;
    case VCF_CUTOFF:
      setVCFCutoff(value);
      break;
    case VCF_RESONANCE:
      setVCFResonance(value);
      break;
    case VCF_ENVELOPE:
      setVCFEnvelope(value);
      break;
    case EG_ATTACK:
      setEGAttack(value);
      break;
    case EG_DECAY_PLUS_RELEASE:
      setEGDecayPlusRelease(value);
      break;
    case EG_SUSTAIN:
      setEGSustain(value);
      break;
    }
  }

  inline static void setVCO1Waveform(uint8_t value)
  {
    soundOff();
    VCO<1>::setWaveform(value);
    resetPhase();
  }

  inline static void setVCO1CoarseTune(uint8_t value)
  {
    soundOff();
    VCO<1>::setCoarseTune(value);
    resetPhase();
  }

  inline static void setVCO2Waveform(uint8_t value)
  {
    soundOff();
    VCO<2>::setWaveform(value);
    resetPhase();
  }

  inline static void setVCO2CoarseTune(uint8_t value)
  {
    soundOff();
    VCO<2>::setCoarseTune(value);
    resetPhase();
  }

  inline static void setVCO2_fine_tune(uint8_t value)
  {
    soundOff();
    VCO<2>::setFineTune(value);
    resetPhase();
  }

  inline static void setVCO3Waveform(uint8_t value)
  {
    soundOff();
    VCO<3>::setWaveform(value);
    resetPhase();
  }

  inline static void setVCO3CoarseTune(uint8_t value)
  {
    soundOff();
    VCO<3>::setCoarseTune(value);
    resetPhase();
  }

  inline static void setVCO3_fine_tune(uint8_t value)
  {
    soundOff();
    VCO<3>::setFineTune(value);
    resetPhase();
  }

  inline static void setVCFCutoff(uint8_t value)
  {
    soundOff();
    VCF::setCutoff(value);
    resetPhase();
  }

  inline static void setVCFResonance(uint8_t value)
  {
    soundOff();
    VCF::setResonance(value);
    resetPhase();
  }

  inline static void setVCFEnvelope(uint8_t value)
  {
    soundOff();
    VCF::setEnvelope(value);
    resetPhase();
  }

  inline static void setEGAttack(uint8_t value)
  {
    soundOff();
    EG::setAttack(value);
    resetPhase();
  }

  inline static void setEGDecayPlusRelease(uint8_t value)
  {
    soundOff();
    EG::setDecayPlusRelease(value);
    resetPhase();
  }

  inline static void setEGSustain(uint8_t value)
  {
    soundOff();
    EG::setSustain(value);
    resetPhase();
  }

  inline static void allNotesOff(uint8_t value)
  {
    EG::noteOff();
  }

  inline static void programChange(uint8_t program_number)
  {
    soundOff();
    const uint8_t* p = g_programTable + (program_number * PROGRAM_SIZE);
    VCO<1>::setWaveform(*p++);
    VCO<1>::setCoarseTune(*p++);
    VCO<1>::setFineTune(64);
    VCO<2>::setWaveform(*p++);
    VCO<2>::setCoarseTune(*p++);
    VCO<2>::setFineTune(*p++);
    VCO<3>::setWaveform(*p++);
    VCO<3>::setCoarseTune(*p++);
    VCO<3>::setFineTune(*p++);
    VCF::setCutoff(*p++);
    VCF::setResonance(*p++);
    VCF::setEnvelope(*p++);
    EG::setAttack(*p++);
    EG::setDecayPlusRelease(*p++);
    EG::setSustain(*p++);
    resetPhase();
  }
};

uint8_t Synth::m_systemExclusive = false;
uint8_t Synth::m_systemDataRemaining = 0;
uint8_t Synth::m_runningStatus = STATUS_BYTE_INVALID;
uint8_t Synth::m_firstData = DATA_BYTE_INVALID;
uint8_t Synth::m_noteNumber = 60;
