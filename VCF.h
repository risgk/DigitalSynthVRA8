#pragma once

#include "Common.h"
#include "LPFTable.h"

class VCF
{
  static const uint8_t* m_lpfTable;
  static uint8_t        m_cutoff;
  static uint8_t        m_resonance;
  static uint8_t        m_envelope;
  static int8_t         m_x1;
  static int8_t         m_x2;
  static int8_t         m_y1;
  static int8_t         m_y2;

public:
  inline static void setCutoff(uint8_t cutoff)
  {
    m_cutoff = cutoff;
  }

  inline static void setResonance(uint8_t resonance)
  {
    m_resonance = resonance;
    if (resonance & 0x40) {
      m_lpfTable = g_lpfTableQSqrt2;
    } else {
      m_lpfTable = g_lpfTableQ1OverSqrt2;
    }
  }

  inline static void setEnvelope(uint8_t envelope)
  {
    m_envelope = envelope;
  }

  inline static int8_t clock(int8_t a, uint8_t k)
  {
    uint8_t cutoff = m_cutoff + highByte(m_envelope * (uint8_t) (k << (uint8_t) 1));
    if (cutoff & 0x80) {
      cutoff = 127;
    }

    const uint8_t* p = m_lpfTable + (uint16_t) (cutoff * (uint8_t) 4);
    uint8_t b1OverA0 = pgm_read_byte(p++);
    uint8_t b2OverA0 = pgm_read_byte(p++);
    uint8_t a1OverA0 = pgm_read_byte(p++);
    uint8_t a2OverA0 = pgm_read_byte(p++);

    int8_t x0 = a;
    int8_t y0 = highByte(((b2OverA0 * x0)   + (b1OverA0 * m_x1) + (b2OverA0 * m_x2) +
                          (a1OverA0 * m_y1) - (a2OverA0 * m_y2)) << 2);
    m_x2 = m_x1;
    m_y2 = m_y1;
    m_x1 = x0;
    m_y1 = y0;

    return y0;
  }
};

const uint8_t* VCF::m_lpfTable  = g_lpfTableQ1OverSqrt2;
uint8_t        VCF::m_cutoff    = 127;
uint8_t        VCF::m_resonance = 0;
uint8_t        VCF::m_envelope  = 0;
int8_t         VCF::m_x1        = 0;
int8_t         VCF::m_x2        = 0;
int8_t         VCF::m_y1        = 0;
int8_t         VCF::m_y2        = 0;
