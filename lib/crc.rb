require 'digest/crc32'

module Digest
  class CRC3000 < CRC32

    WIDTH = 4

    INIT_CRC = 0xffffffff

    XOR_MASK = 0xffffffff

    TABLE = [
      # ....
    ].freeze

    def update(data)
      data.each_byte do |b|
        @crc = (((@crc >> 8) & 0x00ffffff) ^ @table[(@crc ^ b) & 0xff])
      end

      return self
    end
  end
end
