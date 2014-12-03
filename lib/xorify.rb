module RubyCrc
  class Xorify

    def initialize
      @inc = CRC_CODE_STR.length
    end

    def checksum(origin, crc = CRC_CODE_STR)
      checksum = "#{origin}#{crc_polynomial_degree}"

      puts "Start: #{checksum}"

      while checksum.length > 5
        xor = apply(checksum)

        puts " --xor: #{xor}"

        checksum = replace_front_of(checksum, xor)

        puts " -- replace front: #{checksum}"

        checksum = prune_zeros(checksum)

        puts " --pruned: #{checksum}"
      end

      checksum
    end

    def assing_cheksum(payload, checksum)
      [payload, checksum].join('')
    end

    def crc_polynomial_degree
      "0000"
    end

    # Loop acroos the origin and apply xor with crc code
    # => The XOR is applied in both two at index [i]
    # => inc is the length of polynomial crc to apply xor
    def apply(origin, crc = CRC_CODE_STR)
      xorted = ""

      puts "#{origin[0..4]} ^ #{crc}"

      @inc.times do |i|
        xorted << (origin[i].to_i(10) ^ crc[i].to_i(10)).to_s
        puts "xor[#{xorted}]"
      end

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
