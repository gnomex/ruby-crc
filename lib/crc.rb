# require 'digest/crc32'

module RubyCrc

  CRC_CODE = 0b10011 # crc x⁴ + x + 1
  CRC_CODE_STR = '10011' # crc x⁴ + x + 1 :string
  CRC_ESCAPE = '0'

  class CRC #< Digest::CRC

    # Append 0 when found 5 1's
    def bypass_bits(word)
      counter = 0 # temporary counter
      escaped_word = "" # final word with bits escaped
      older = "0"

      word.each_char do |bit|
        escaped_word << bit

        counter = 0 if bit == "0"
        counter += 1 if bit == "1" and older == "1"

        older = bit

        if counter == 4 # 0..4 = 5 items
          escaped_word << CRC_ESCAPE

          counter = 0
          older = "0" # Must be 0 to work
        end
      end

      escaped_word
    end

    # WIDTH = 4

    # INIT_CRC = 0xffffffff

    # XOR_MASK = 0xffffffff

    # TABLE = [
    #   # ....
    # ].freeze

    # def update(data)
    #   data.each_byte do |b|
    #     @crc = (((@crc >> 8) & 0x00ffffff) ^ @table[(@crc ^ b) & 0xff])
    #   end

    #   return self
    # end
  end
end
