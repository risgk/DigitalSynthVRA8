$program_table = [
  # VCO 1 Waveform, Coarse Tune,
  # VCO 2 Waveform, Coarse Tune, Fine Tune,
  # VCO 3 Waveform, Coarse Tune, Fine Tune,
  # VCF Cutoff Frequency, Resonance, Envelope Amount,
  # EG Attack Time, Decay Time, Sustain Level
  # Dummy, Dummy

  # Sub Osc Lead
  SAWTOOTH, 64,
  SAWTOOTH, 64, 70,
  TRIANGLE, 52, 64,
  85, ON, 42,
  21, 85, 127,
  64, 64,

  # Saw Lead
  SAWTOOTH, 64,
  SAWTOOTH, 64, 70,
  SAWTOOTH, 64, 64,
  85, ON, 42,
  21, 85, 127,
  64, 64,

  # Square Lead
  SQUARE, 64,
  SQUARE, 64, 70,
  SQUARE, 64, 64,
  85, OFF, 42,
  42, 85, 127,
  64, 64,

  # Synth Pad
  SAWTOOTH, 64,
  SAWTOOTH, 64, 70,
  TRIANGLE, 64, 64,
  42, ON, 85,
  106, 106, 127,
  64, 64,

  # Synth Bass
  TRIANGLE, 64,
  SAWTOOTH, 64, 70,
  SAWTOOTH, 64, 64,
  0, ON, 127,
  21, 85, 0,
  64, 64,
]
