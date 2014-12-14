#pragma once

#include "Common.h"
#include "EnvTable.h"

class EG
{
  static const uint8_t  STATE_ATTACK        = 0;
  static const uint8_t  STATE_DECAY_SUSTAIN = 1;
  static const uint8_t  STATE_RELEASE       = 3;
  static const uint8_t  STATE_IDLE          = 4;
  static const uint16_t LEVEL16_127         = 32512;
  static const uint16_t LEVEL16_190_5       = 48768;

  static uint16_t m_attackRate;
  static uint16_t m_decayRate;
  static uint16_t m_sustainLevel16;
  static uint8_t  m_state;
  static uint16_t m_level16;
  static uint8_t  m_count;

public:
  static void setAttackTime(uint8_t attackTime)
  {
    m_attackRate = g_envTableAttackRateFromTime[attackTime];
  }

  static void setDecayTime(uint8_t decayTime)
  {
    m_decayRate = g_envTableDecayRateFromTime[decayTime];
  }

  static void setSustainLevel(uint8_t sustainLevel)
  {
    m_sustainLevel16 = sustainLevel << (uint16_t) 8;
  }

  static void noteOn()
  {
    m_state = STATE_ATTACK;
  }

  static void noteOff()
  {
    m_state = STATE_RELEASE;
  }

  static void soundOff()
  {
    m_state = STATE_IDLE;
    m_level16 = 0;
  }

  static uint8_t clock()
  {
    m_count++;
    if (m_count < EG_UPDATE_INTERVAL) {
      return highByte(m_level16);
    }
    m_count = 0;

    switch (m_state) {
    case STATE_ATTACK:
      m_level16 = LEVEL16_190_5 - (uint16_t) (((LEVEL16_190_5 - m_level16) *
                                               (uint32_t) m_attackRate) >> 16);
      if (m_level16 >= LEVEL16_127) {
        m_state = STATE_DECAY_SUSTAIN;
        m_level16 = LEVEL16_127;
      }
      break;
    case STATE_DECAY_SUSTAIN:
      if (m_level16 > m_sustainLevel16) {
        if (m_level16 <= (32 + m_sustainLevel16)) {
          m_level16 = m_sustainLevel16;
        } else {
          m_level16 = m_sustainLevel16 + (uint16_t) (((m_level16 - m_sustainLevel16) *
                                                      (uint32_t) m_decayRate) >> 16);
        }
      }
      break;
    case STATE_RELEASE:
      m_level16 = (uint16_t) ((m_level16 * (uint32_t) m_decayRate) >> 16);
      if (m_level16 <= 32) {
        m_state = STATE_IDLE;
        m_level16 = 0;
      }
      break;
    case STATE_IDLE:
      m_level16 = 0;
      break;
    }

    return highByte(m_level16);
  }
};

uint16_t EG::m_attackRate     = g_envTableAttackRateFromTime[0];
uint16_t EG::m_decayRate      = g_envTableDecayRateFromTime[0];
uint16_t EG::m_sustainLevel16 = LEVEL16_127;
uint8_t  EG::m_state          = STATE_IDLE;
uint16_t EG::m_level16        = 0;
uint8_t  EG::m_count          = 0;
