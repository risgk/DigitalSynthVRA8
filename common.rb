def high_byte(us)
  return (us >> 8)
end

def low_byte(us)
  return (us & 0xFF)
end
