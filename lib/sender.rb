module RubyCrc

  # Transmitter
  # => Compute the checksum
  # => Escape flags, bit by bit algorithm
  # => Insert flags
  # => Transform the frame to string and append all frames
  # => Save the frames on a file
  class Sender
    attr_reader :buffer, :crc

    def initialize
      @crc = CRC.new
      @buffer = [] # initialize the buffer
      @frames = [] # frame buffer
      # load_payloads # load payloads from file to buffer
    end

    # Build a frame and transmit it
    def build
      mount_frames
      transmit
    end

    # Transmit a frame across the physical layer.... (Realy? No, save to a file)
    def transmit
      if @frames.any? # check is exists something on buffer
        File.open(RubyCrc::FRAMES_OUT, "w") do |f|
          f.write @frames.join('')
        end
      end
    end

    # Load payloads from a file
    def load_payloads
      File.open(RubyCrc::PAYLOAD_IN, "r") do |f|
        f.each_line do |line|
          @buffer << line.chomp unless line.empty?
        end
      end
    end
    private

    # Make the frame with flags and add to buffer
    def mount_frames
      @buffer.each do |payload|
        @frames << apply_flags( @crc.build( payload ) )
      end
    end

    # Apply bit flags
    # Force flags to string
    def apply_flags(frame)
      [ BIT_FLAG_STR, frame, BIT_FLAG_STR ].join('')
    end
  end
end
