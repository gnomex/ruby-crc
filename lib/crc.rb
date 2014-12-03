module RubyCrc

  class CRC
    def initialize
      @xorify = Xorify.new
    end

    def build(payload)
      checksum = @xorify.pack(payload)

      apply_flags "#{payload}#{checksum}"
    end

    def undo(frame)
      @xorify.unpack(frame)
    end

    # # Append 0 when found 5 1's
    # def bypass_bits(word)
    #   counter = 0 # temporary counter
    #   escaped_word = "" # final word with bits escaped
    #   older = "0"

    #   word.each_char do |bit|
    #     escaped_word << bit

    #     counter = 0 if bit == "0"
    #     counter += 1 if bit == "1" and older == "1"

    #     older = bit

    #     if counter == 4 # 0..4 = 5 items
    #       escaped_word << CRC_ESCAPE

    #       counter = 0
    #       older = "0" # Must be 0 to work
    #     end
    #   end

    #   escaped_word
    # end

    def bypass(payload)
      payload.gsub(/1{5}/, "111110")
    end

    def un_bypass(frame)
      # !! always return a boolean
      if !!frame.match(/1{5}0/)
        origin.gsub(/1{5}0/, "11111")
      end
    end

    private
    def apply_flags(frame)
      [BIT_FLAG, frame, BIT_FLAG].join('')
    end
  end
end
