module RubyCrc
  # Make the xor
  # All logic to brushing the chunk of bits represented on a string
  class Xorify

    # Defines the inc
    # => inc is the length of polynomial crc to apply xor, defined in RubyCrc module
    def initialize
      @inc = CRC_CODE_STR.length
    end

    def pack(payload)
      checksum "#{payload}#{crc_polynomial_degree}"
    end

    def unpack(frame)
      checksum "#{frame}" #Force string
    end

    private
    # Create a checksum from a chunk of bits
    # => in: '1101011111'
    # => algorithm: '11010111110000'
    # => result: '10'
    def checksum(origin, crc = CRC_CODE_STR)
      checksum = origin
      # The logic:
      # => iterate over the chunck, using inc elements each time
      # => apply the xor at these elements
      # => replace the inc first elements of checksum (used to xor)
      # => prune zeros front of checksum
      # => @return: the checksum of chunk
      while checksum.length > @inc
        xor = apply(checksum)
        # puts " --xor: #{xor}" # Low debug mode

        checksum = replace_front_of(checksum, xor)
        # puts " -- replace front: #{checksum}" # Low debug mode

        checksum = prune_zeros(checksum)
        # puts " --pruned: #{checksum}" # Low debug mode
      end

      # checksum
      complement(checksum)
    end

    # Complement checksum with zeros
    def complement(checksum)
      while checksum.length < crc_polynomial_degree.length
        checksum = ['0', checksum].join('')
      end

      checksum
    end

    def assing_cheksum(payload, checksum)
      [payload, checksum].join('')
    end

    # Append the number of zeros for create a checksum
    def crc_polynomial_degree
      "0000"
    end

    # Loop acroos the origin and apply xor with crc code
    # => The XOR is applied in both two at index [i]
    # => inc is the length of polynomial crc to apply xor
    def apply(origin, crc = CRC_CODE_STR)
      xorted = ""

      # puts "#{origin[0..4]} ^ #{crc}" # Low debug mode

      @inc.times do |i|
        xorted << (origin[i].to_i(10) ^ crc[i].to_i(10)).to_s
      end

      # puts "xor[#{xorted}]" # Low debug mode
      xorted
    end

    # Replace first elements for a string
    def replace_front_of(origin, replacement)
      "#{replacement}#{origin[@inc..-1]}"
    end

    # Shift right to remove the 5 first chars at ""
    # => 5 is the length of polynomial crc to apply xor
    def >>(origin)
      origin.gsub(/^.{5}/, "")
    end

    def prune_zeros(origin)
      origin.gsub(/^.0*/, "")
    end
  end
end
