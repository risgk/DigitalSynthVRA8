$program_table = [

  # Sub Osc Lead
  SAWTOOTH, 64,         # VCO 1 Waveform, Coarse Tune,
  SAWTOOTH, 64, 74,     # VCO 2 Waveform, Coarse Tune, Fine Tune,
  TRIANGLE, 52, 64,     # VCO 3 Waveform, Coarse Tune, Fine Tune,
  64, ON, ON,          # VCF Cutoff, Resonance, Envelope,
  0, 96, 127,           # EG Attack, Decay/Release, Sustain

  # Saw Lead
  SAWTOOTH, 64,         # VCO 1 Waveform, Coarse Tune,
  SAWTOOTH, 64, 74,     # VCO 2 Waveform, Coarse Tune, Fine Tune,
  SAWTOOTH, 64, 64,     # VCO 3 Waveform, Coarse Tune, Fine Tune,
  64, ON, ON,          # VCF Cutoff, Resonance, Envelope,
  0, 96, 127,           # EG Attack, Decay/Release, Sustain

  # Square Lead
  SQUARE, 64,           # VCO 1 Waveform, Coarse Tune,
  SQUARE, 64, 74,       # VCO 2 Waveform, Coarse Tune, Fine Tune,
  SQUARE, 64, 64,       # VCO 3 Waveform, Coarse Tune, Fine Tune,
  64, OFF, ON,         # VCF Cutoff, Resonance, Envelope,
  0, 96, 127,           # EG Attack, Decay/Release, Sustain

  # Synth Pad
  SAWTOOTH, 64,         # VCO 1 Waveform, Coarse Tune,
  SAWTOOTH, 64, 74,     # VCO 2 Waveform, Coarse Tune, Fine Tune,
  SINE, 64, 64,         # VCO 3 Waveform, Coarse Tune, Fine Tune,
  64, OFF, ON,         # VCF Cutoff, Resonance, Envelope,
  127, 127, 127,        # EG Attack, Decay/Release, Sustain

  # Synth Bass
  TRIANGLE, 64,         # VCO 1 Waveform, Coarse Tune,
  SAWTOOTH, 64, 74,     # VCO 2 Waveform, Coarse Tune, Fine Tune,
  SAWTOOTH, 64, 64,     # VCO 3 Waveform, Coarse Tune, Fine Tune,
  0, ON, ON,            # VCF Cutoff, Resonance, Envelope,
  0, 127, 0,            # EG Attack, Decay/Release, Sustain
]
