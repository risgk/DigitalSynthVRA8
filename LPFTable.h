#pragma once

const uint8_t g_LPFTable_Q1OverSqrt2[] PROGMEM = {
    4,   2,  93,  37,   4,   2,  93,  37,   4,   2,  92,  36,   4,   2,  92,  36,
    4,   2,  92,  36,   4,   2,  91,  36,   4,   2,  91,  35,   4,   2,  90,  35,
    4,   2,  90,  35,   5,   2,  90,  35,   5,   2,  89,  34,   5,   2,  89,  34,
    5,   2,  88,  34,   5,   2,  88,  34,   5,   3,  88,  34,   5,   3,  87,  33,
    5,   3,  87,  33,   5,   3,  86,  33,   5,   3,  86,  33,   6,   3,  85,  32,
    6,   3,  85,  32,   6,   3,  84,  32,   6,   3,  84,  32,   6,   3,  83,  31,
    6,   3,  83,  31,   6,   3,  83,  31,   6,   3,  82,  31,   6,   3,  82,  30,
    7,   3,  81,  30,   7,   3,  81,  30,   7,   3,  80,  30,   7,   3,  80,  29,
    7,   4,  79,  29,   7,   4,  79,  29,   7,   4,  78,  29,   7,   4,  78,  28,
    8,   4,  77,  28,   8,   4,  76,  28,   8,   4,  76,  28,   8,   4,  75,  27,
    8,   4,  75,  27,   8,   4,  74,  27,   8,   4,  74,  27,   9,   4,  73,  26,
    9,   4,  73,  26,   9,   4,  72,  26,   9,   5,  71,  26,   9,   5,  71,  25,
    9,   5,  70,  25,  10,   5,  70,  25,  10,   5,  69,  25,  10,   5,  68,  24,
   10,   5,  68,  24,  10,   5,  67,  24,  11,   5,  67,  24,  11,   5,  66,  23,
   11,   5,  65,  23,  11,   6,  65,  23,  11,   6,  64,  23,  12,   6,  63,  22,
   12,   6,  63,  22,  12,   6,  62,  22,  12,   6,  61,  22,  12,   6,  61,  21,
   13,   6,  60,  21,  13,   6,  59,  21,  13,   7,  59,  21,  13,   7,  58,  20,
   14,   7,  57,  20,  14,   7,  56,  20,  14,   7,  56,  20,  14,   7,  55,  20,
   15,   7,  54,  19,  15,   7,  53,  19,  15,   8,  53,  19,  15,   8,  52,  19,
   16,   8,  51,  18,  16,   8,  50,  18,  16,   8,  50,  18,  16,   8,  49,  18,
   17,   8,  48,  17,  17,   9,  47,  17,  17,   9,  46,  17,  18,   9,  46,  17,
   18,   9,  45,  17,  18,   9,  44,  16,  19,   9,  43,  16,  19,   9,  42,  16,
   19,  10,  41,  16,  20,  10,  40,  16,  20,  10,  40,  15,  20,  10,  39,  15,
   21,  10,  38,  15,  21,  10,  37,  15,  21,  11,  36,  15,  22,  11,  35,  14,
   22,  11,  34,  14,  22,  11,  33,  14,  23,  11,  32,  14,  23,  12,  31,  14,
   24,  12,  30,  14,  24,  12,  29,  13,  24,  12,  28,  13,  25,  12,  27,  13,
   25,  13,  26,  13,  26,  13,  25,  13,  26,  13,  24,  13,  27,  13,  23,  12,
   27,  14,  22,  12,  28,  14,  21,  12,  28,  14,  20,  12,  29,  14,  19,  12,
   29,  15,  18,  12,  30,  15,  17,  12,  30,  15,  16,  12,  31,  15,  14,  12,
   31,  16,  13,  11,  32,  16,  12,  11,  32,  16,  11,  11,  33,  16,  10,  11,
   33,  17,   9,  11,  34,  17,   7,  11,  34,  17,   6,  11,  35,  18,   5,  11,
   36,  18,   4,  11,  36,  18,   3,  11,  37,  18,   1,  11,  37,  19,   0,  11,
};

const uint8_t g_LPFTable_QSqrt2[] PROGMEM = {
    4,   2, 104,  49,   4,   2, 104,  49,   4,   2, 104,  48,   5,   2, 103,  48,
    5,   2, 103,  48,   5,   2, 103,  48,   5,   2, 102,  48,   5,   2, 102,  48,
    5,   3, 102,  48,   5,   3, 101,  47,   5,   3, 101,  47,   5,   3, 100,  47,
    5,   3, 100,  47,   6,   3, 100,  47,   6,   3,  99,  47,   6,   3,  99,  47,
    6,   3,  99,  46,   6,   3,  98,  46,   6,   3,  98,  46,   6,   3,  97,  46,
    6,   3,  97,  46,   7,   3,  97,  46,   7,   3,  96,  45,   7,   3,  96,  45,
    7,   3,  95,  45,   7,   4,  95,  45,   7,   4,  94,  45,   7,   4,  94,  45,
    8,   4,  93,  45,   8,   4,  93,  44,   8,   4,  93,  44,   8,   4,  92,  44,
    8,   4,  92,  44,   8,   4,  91,  44,   8,   4,  91,  44,   9,   4,  90,  43,
    9,   4,  90,  43,   9,   4,  89,  43,   9,   5,  89,  43,   9,   5,  88,  43,
   10,   5,  87,  43,  10,   5,  87,  42,  10,   5,  86,  42,  10,   5,  86,  42,
   10,   5,  85,  42,  11,   5,  85,  42,  11,   5,  84,  41,  11,   5,  83,  41,
   11,   6,  83,  41,  11,   6,  82,  41,  12,   6,  82,  41,  12,   6,  81,  41,
   12,   6,  80,  40,  12,   6,  80,  40,  13,   6,  79,  40,  13,   6,  78,  40,
   13,   6,  78,  40,  13,   7,  77,  40,  14,   7,  76,  39,  14,   7,  76,  39,
   14,   7,  75,  39,  14,   7,  74,  39,  15,   7,  74,  39,  15,   7,  73,  38,
   15,   8,  72,  38,  15,   8,  71,  38,  16,   8,  71,  38,  16,   8,  70,  38,
   16,   8,  69,  38,  17,   8,  68,  37,  17,   8,  67,  37,  17,   9,  67,  37,
   18,   9,  66,  37,  18,   9,  65,  37,  18,   9,  64,  37,  19,   9,  63,  36,
   19,   9,  62,  36,  19,  10,  61,  36,  20,  10,  61,  36,  20,  10,  60,  36,
   20,  10,  59,  36,  21,  10,  58,  35,  21,  11,  57,  35,  22,  11,  56,  35,
   22,  11,  55,  35,  22,  11,  54,  35,  23,  11,  53,  35,  23,  12,  52,  34,
   24,  12,  51,  34,  24,  12,  50,  34,  25,  12,  49,  34,  25,  13,  48,  34,
   25,  13,  47,  34,  26,  13,  46,  34,  26,  13,  45,  33,  27,  13,  43,  33,
   27,  14,  42,  33,  28,  14,  41,  33,  28,  14,  40,  33,  29,  14,  39,  33,
   29,  15,  38,  33,  30,  15,  36,  32,  31,  15,  35,  32,  31,  16,  34,  32,
   32,  16,  33,  32,  32,  16,  32,  32,  33,  16,  30,  32,  33,  17,  29,  32,
   34,  17,  28,  32,  35,  17,  26,  32,  35,  18,  25,  31,  36,  18,  24,  31,
   36,  18,  22,  31,  37,  19,  21,  31,  38,  19,  20,  31,  38,  19,  18,  31,
   39,  20,  17,  31,  40,  20,  15,  31,  40,  20,  14,  31,  41,  21,  12,  31,
   42,  21,  11,  31,  43,  21,   9,  31,  43,  22,   8,  31,  44,  22,   6,  31,
   45,  22,   5,  31,  46,  23,   3,  31,  46,  23,   2,  31,  47,  24,   0,  31,
};

