#pragma once

#include "Common.h"
#include "EnvTable.h"

class EG
{
  const static uint8_t STATE_ATTACK  = 0;
  const static uint8_t STATE_DECAY   = 1;
  const static uint8_t STATE_SUSTAIN = 2;
  const static uint8_t STATE_RELEASE = 3;
  const static uint8_t STATE_IDLE    = 4;

  static uint8_t  m_attackSpeed;
  static uint8_t  m_decayPlusReleaseSpeed;
  static uint8_t  m_sustainLevel;
  static uint8_t  m_state;
  static uint16_t m_count;
  static int8_t   m_level;

public:
  inline static void setAttack(uint8_t attackTime)
  {
    m_attackSpeed = pgm_read_byte(g_envTableSpeedFromTime + attackTime);
  }

  inline static void setDecayPlusRelease(uint8_t decayPlusReleaseTime)
  {
    m_decayPlusReleaseSpeed = pgm_read_byte(g_envTableSpeedFromTime + decayPlusReleaseTime);
  }

  inline static void setSustain(uint8_t sustainLevel)
  {
    m_sustainLevel = sustainLevel;
  }

  inline static void noteOn()
  {
    if (m_level == 127) {
      m_state = STATE_DECAY;
      m_count = 0;
    } else {
      m_state = STATE_ATTACK;
      m_count = pgm_read_byte(g_envTableAttackInverse + m_level) << 8;
    }
  }

  inline static void noteOff()
  {
    switch (m_state) {
    case STATE_ATTACK:
    case STATE_DECAY:
    case STATE_SUSTAIN:
      m_state = STATE_RELEASE;
      m_count = pgm_read_byte(g_envTableDecayPlusReleaseInverse + m_level) << 8;
    }
  }

  inline static void soundOff()
  {
    m_state = STATE_IDLE;
    m_count = 0;
    m_level = 0;
  }

  inline static uint8_t clock()
  {
    switch (m_state) {
    case STATE_ATTACK:
      m_count += m_attackSpeed;
      if (highByte(m_count) < 255) {
        m_level = pgm_read_byte(g_envTableAttack + highByte(m_count));
      } else {
        m_state = STATE_DECAY;
        m_count = 0;
        m_level = 127;
      }
      break;
    case STATE_DECAY:
      m_count += m_decayPlusReleaseSpeed;
      m_level = pgm_read_byte(g_envTableDecayPlusRelease + highByte(m_count));
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
      if (highByte(m_count) < 255) {
        m_level = pgm_read_byte(g_envTableDecayPlusRelease + highByte(m_count));
      } else {
        m_state = STATE_IDLE;
        m_count = 0;
        m_level = 0;
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
