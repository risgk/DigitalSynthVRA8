#pragma once

#include "Common.h"
#include "EnvTable.h"

class EG
{
  static const uint8_t STATE_ATTACK  = 0;
  static const uint8_t STATE_DECAY   = 1;
  static const uint8_t STATE_SUSTAIN = 2;
  static const uint8_t STATE_RELEASE = 3;
  static const uint8_t STATE_IDLE    = 4;

  static uint8_t  m_attackSpeed;
  static uint8_t  m_decayPlusReleaseSpeed;
  static uint8_t  m_sustainLevel;
  static uint8_t  m_state;
  static uint16_t m_count;
  static int8_t   m_level;

public:
  inline static void setAttack(uint8_t attackTime)
  {
    m_attackSpeed = *(g_envTableSpeedFromTime + attackTime);
  }

  inline static void setDecayPlusRelease(uint8_t decayPlusReleaseTime)
  {
    m_decayPlusReleaseSpeed = *(g_envTableSpeedFromTime + decayPlusReleaseTime);
  }

  inline static void setSustain(uint8_t sustainLevel)
  {
    m_sustainLevel = sustainLevel;
  }

  inline static void noteOn()
  {
    m_state = STATE_ATTACK;
    m_count = *(g_envTableAttackInverse + m_level) << 8;
  }

  inline static void noteOff()
  {
    m_state = STATE_RELEASE;
    m_count = *(g_envTableDecayPlusReleaseInverse + m_level) << 8;
  }

  inline static void soundOff()
  {
    m_state = STATE_IDLE;
  }

  inline static uint8_t clock()
  {
    switch (m_state) {
    case STATE_ATTACK:
      m_count += m_attackSpeed;
      m_level = *(g_envTableAttack + highByte(m_count));
      if (highByte(m_count) == (uint8_t) 255) {
        m_state = STATE_DECAY;
        m_count = 0;
      }
      break;
    case STATE_DECAY:
      m_count += m_decayPlusReleaseSpeed;
      m_level = *(g_envTableDecayPlusRelease + highByte(m_count));
      if (m_level <= m_sustainLevel) {
        m_state = STATE_SUSTAIN;
        m_level = m_sustainLevel;
      }
      break;
    case STATE_SUSTAIN:
      m_level = m_sustainLevel;
      break;
    case STATE_RELEASE:
      m_count += m_decayPlusReleaseSpeed;
      m_level = *(g_envTableDecayPlusRelease + highByte(m_count));
      if (highByte(m_count) == (uint8_t) 255) {
        m_state = STATE_IDLE;
      }
      break;
    case STATE_IDLE:
      m_level = 0;
      break;
    }

    return m_level;
  }
};

uint8_t  EG::m_attackSpeed           = 255;
uint8_t  EG::m_decayPlusReleaseSpeed = 255;
uint8_t  EG::m_sustainLevel          = 127;
uint8_t  EG::m_state                 = STATE_IDLE;
uint16_t EG::m_count                 = 0;
int8_t   EG::m_level                 = 0;
