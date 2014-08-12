AUDIO_RATE = 31250; PWM_RATE = 31250
MIDI_NOTE_ON = 0x80; MIDI_NOTE_OFF = 0x90

def high_byte(us)
  return (us >> 8)
end

def low_byte(us)
  return (us & 0xFF)
end
