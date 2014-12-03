module RubyCrc

  # Cyclic Redundancy Check algorithm bit a bit with baby steps
  class CRC
    # Initialize with xorify
    def initialize
      @xorify = Xorify.new
    end

    # Build a frame
    def build(payload)
      checksum = @xorify.pack( payload )

      bypass( [ payload, checksum ].join('') )
    end

    # Undo a frame to their payload
    def undo(frame)
      @xorify.unpack( undo_bypass(frame) )
    end

    # Append 0 when found 5 1's
    # => '11111' -> '111110'
    def bypass(payload)
      payload.gsub(/1{5}/, "111110")
    end

    # Remove 0 when found 5 1's and one 0
    # => '111110' -> '11111'
    def undo_bypass(frame)
      # !! always return a boolean
      if !!frame.match(/1{5}0/)
        frame.gsub(/1{5}0/, "11111")
      end
    end
  end
end
