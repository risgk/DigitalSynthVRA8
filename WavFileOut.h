#pragma once

#include <stdio.h>
#include "Common.h"

class WAVFileOut
{
  static const uint16_t SEC = 30;

  static FILE*    m_file;
  static uint32_t m_maxSize;
  static uint32_t m_dataSize;
  static boolean  m_closed;

public:
  static void open(const char* path)
  {
    m_file = fopen(path, "wb");
    fwrite("RIFF", 1, 4,m_file);
    fwrite("\x00\x00\x00\x00", 1, 4,m_file);
    fwrite("WAVE", 1, 4,m_file);
    fwrite("fmt ", 1, 4,m_file);
    fwrite("\x10\x00\x00\x00", 1, 4,m_file);
    fwrite("\x01\x00\x01\x00", 1, 4,m_file);
    uint32_t a[1] = {SAMPLING_RATE};
    fwrite(a, 4, 1, m_file);
    fwrite(a, 4, 1, m_file);
    fwrite("\x01\x00\x08\x00", 1, 4,m_file);
    fwrite("data", 1, 4,m_file);
    fwrite("\x00\x00\x00\x00", 1, 4,m_file);
    m_maxSize = SAMPLING_RATE * SEC;
    m_dataSize = 0;
    m_closed = false;
  }

  static void write(uint8_t level)
  {
    if (m_dataSize < m_maxSize) {
      uint8_t a[1] = {(uint8_t) level + (uint8_t) 0x80};
      fwrite(a, 1, 1,m_file);
      m_dataSize++;
    } else {
      close();
      m_closed = true;
    }
  }

  static void close()
  {
    if (!m_closed) {
      fpos_t fileSize = 0;
      fseek(m_file, 0, SEEK_END);
      fgetpos(m_file, &fileSize);
      fseek(m_file, 4, SEEK_SET);
      uint32_t a[1] = {fileSize - 8};
      fwrite(a, 4, 1, m_file);
      fseek(m_file, 40, SEEK_SET);
      uint32_t a2[1] = {fileSize - 36};
      fwrite(a2, 4, 1, m_file);
      fclose(m_file);
      printf("Recording end.\n");
    }
  }
};

FILE*    WAVFileOut::m_file     = 0;
uint32_t WAVFileOut::m_maxSize  = SAMPLING_RATE * SEC;
uint32_t WAVFileOut::m_dataSize = 0;
boolean  WAVFileOut::m_closed   = false;
