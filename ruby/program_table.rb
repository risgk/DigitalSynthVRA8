$program_table = [
  # VCO 1 Waveform, Coarse Tune,
  # VCO 2 Waveform, Coarse Tune, Fine Tune,
  # VCO 3 Waveform, Coarse Tune, Fine Tune,
  # VCF Cutoff, Resonance, Envelope,
  # EG Attack, Decay + Release, Sustain

  # Sub Osc Lead
  SAWTOOTH, 64,
  SAWTOOTH, 64, 74,
  TRIANGLE, 52, 64,
  0, ON, 127,
  0, 80, 127,

  # Saw Lead
  SAWTOOTH, 64,
  SAWTOOTH, 64, 74,
  SAWTOOTH, 64, 64,
  0, ON, 127,
  0, 80, 127,

  # Square Lead
  SQUARE, 64,
  SQUARE, 64, 74,
  SQUARE, 64, 64,
  0, OFF, 127,
  0, 80, 127,

  # Synth Pad
  SAWTOOTH, 64,
  SAWTOOTH, 64, 74,
  TRIANGLE, 64, 64,
  0, OFF, 127,
  127, 127, 127,

  # Synth Bass
  TRIANGLE, 64,
  SAWTOOTH, 64, 74,
  SAWTOOTH, 64, 64,
  0, ON, 127,
  0, 112, 0,
]
