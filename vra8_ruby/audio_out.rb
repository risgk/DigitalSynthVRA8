require './common'
require 'win32/sound'

class AudioOut
  extend Windows::SoundFunctions

  class << self
    include Windows::SoundStructs

    BUFFER_SIZE = 500
    NUM_OF_BUFFER = 4

    WAVE_MAPPER = -1
    WHDR_DONE = 0x00000001

    def open
      @hwaveout = HWAVEOUT.new
      @waveformatex = WAVEFORMATEX.new(SAMPLING_RATE, 8, 1)
      waveOutOpen(@hwaveout.pointer, WAVE_MAPPER, @waveformatex.pointer, 0, 0, 0)

      @buffer = []
      @wavehdr = []
      @array = Array.new(BUFFER_SIZE, 0x80)
      (0...NUM_OF_BUFFER).each do |i|
        @buffer[i] = FFI::MemoryPointer.new(:uint8, BUFFER_SIZE)
        @buffer[i].write_array_of_uint8(@array)
        @wavehdr[i] = WAVEHDR.new(@buffer[i], BUFFER_SIZE)
        waveOutPrepareHeader(@hwaveout[:i], @wavehdr[i].pointer, @wavehdr[i].size)
        waveOutWrite(@hwaveout[:i], @wavehdr[i].pointer, @wavehdr[i].size)
      end

      @index = 0
      @array = []
    end

    def write(level)
      @array.push(level + 0x80)
      if (@array.length == BUFFER_SIZE)
        while ((@wavehdr[@index][:dwFlags] & WHDR_DONE) == 0)
          # do nothing
        end
        waveOutUnprepareHeader(@hwaveout[:i], @wavehdr[@index].pointer, @wavehdr[@index].size)
        @buffer[@index].write_array_of_uint8(@array)
        waveOutPrepareHeader(@hwaveout[:i], @wavehdr[@index].pointer, @wavehdr[@index].size)
        waveOutWrite(@hwaveout[:i], @wavehdr[@index].pointer, @wavehdr[@index].size)
        @index = (@index + 1) % NUM_OF_BUFFER
        @array = []
      end
    end
  end
end
