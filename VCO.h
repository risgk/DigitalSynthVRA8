#pragma once

#include "Common.h"
#include "FreqTable.h"
#include "WaveTable.h"
#include "WaveTable2.h"

template <uint8_t T>
class VCO
{
  static const uint8_t** m_waveTables;
  static uint8_t         m_courseTune;
  static uint8_t         m_fineTune;
  static uint8_t         m_noteNumber;
  static uint16_t        m_phase;
  static uint16_t        m_freq;

public:
  static void resetPhase()
  {
    m_phase = 0;
  }

  static void setWaveform(uint8_t waveform)
  {
    switch (waveform) {
    case SAWTOOTH:
      m_waveTables = g_waveTablesSawtooth;
      break;
    case SQUARE:
      m_waveTables = g_waveTablesSquare;
      break;
    case TRIANGLE:
      m_waveTables = g_waveTablesTriangle;
      break;
    case SINE:
      m_waveTables = g_waveTablesSine;
      break;
    case PULSE_25:
      m_waveTables = g_waveTablesPulse25;
      break;
    case PULSE_12:
      m_waveTables = g_waveTablesPulse12;
      break;
    case PSEUDO_TRI:
      m_waveTables = g_waveTablesPseudoTri;
      break;
    }
  }

  static void setCoarseTune(uint8_t coarseTune)
  {
    m_courseTune = coarseTune;
    updateFreq();
  }

  static uint8_t coarseTune()
  {
    return m_courseTune;
  }

  static void setFineTune(uint8_t fineTune)
  {
    m_fineTune = fineTune;
    updateFreq();
  }

  static void noteOn(uint8_t noteNumber)
  {
    m_noteNumber = noteNumber;
    updateFreq();
  }

  static uint8_t clock()
  {
    m_phase += m_freq;

    const uint8_t* waveTable = m_waveTables[highByte(m_freq)];
    uint8_t currIndex = highByte(m_phase);
    uint8_t nextIndex = currIndex + 1;
    int8_t currData = pgm_read_byte(waveTable + currIndex);
    int8_t nextData = pgm_read_byte(waveTable + nextIndex);

    int8_t level;
    uint8_t nextWeight = lowByte(m_phase);
    if (nextWeight == 0) {
      level = currData;
    } else {
      uint8_t currWeight = (uint8_t) 0 - nextWeight;
      level = highByte((currData * currWeight) + (nextData * nextWeight));
    }

    return level;
  }

  static void updateFreq()
  {
    uint8_t noteNumber = m_noteNumber + m_courseTune - (uint8_t) 64;
    if (m_fineTune <= (uint8_t) 63) {
      m_freq = pgm_read_word(g_freqTableDetuneMinus + noteNumber);
    } else if (m_fineTune == (uint8_t) 64) {
      m_freq = pgm_read_word(g_freqTableDetuneNone  + noteNumber);
    } else {
      m_freq = pgm_read_word(g_freqTableDetunePlus  + noteNumber);
    }
  }
};

template <uint8_t T> const uint8_t** VCO<T>::m_waveTables = g_waveTablesSawtooth;
template <uint8_t T> uint8_t         VCO<T>::m_courseTune = 64;
template <uint8_t T> uint8_t         VCO<T>::m_fineTune   = 64;
template <uint8_t T> uint8_t         VCO<T>::m_noteNumber = 60;
template <uint8_t T> uint16_t        VCO<T>::m_phase      = 0;
template <uint8_t T> uint16_t        VCO<T>::m_freq       = 0;
