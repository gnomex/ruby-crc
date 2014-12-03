module RubyCrc
  # Receiver
  # => Receive all frames
  # => Identify frames
  # => Resync frames when required
  # => Remove flags
  # => Remove escapes
  # => Verify checksum
  # => Record payload from frames in a file, line separated
  ## Logger
  # => Show payload, checksum and [ok|error]
  class Receiver
    #
    def initialize
      @crc = CRC.new
      @buffered_frames = ""
      @stack = Array.new
      @frames = Array.new
      # load_frames
    end

    # Load frames from a file,
    # => One long line, with a chunck of bits
    def load_frames
      File.open(RubyCrc::FRAMES_OUT, "r") do |f|
        f.each_line do |line|
          @buffered_frames << line.chomp unless line.empty?
          # @buffered_frames << line unless line.empty?
        end
      end
    end

    # Get payloads
    # => Get frame from buffer
    # => if frame no have erros, get payload and make the checksum
    ## Frame with error
    # Is added to buffer because I need to report them!
    def umount_frames
      @stack.each do |item|
        if item[:status] == 'ok'
          checksum = @crc.undo( item[:data] )
          item[:checksum] = checksum

          unless checksum.match(/^0{4}/)
            item[:status] = 'erro'
          end
        end

        @frames.push( item ) # Push to a buffer
      end
    end

    # Transmit a frame across the physical layer.... (Realy? No, save to a file)
    def transmit
      if @frames.any? # check is exists something on buffer
        f = File.open(RubyCrc::PAYLOAD_OUT, "w")

        @frames.each do |frame|
          f.puts frame.to_a.flatten.join(' - ')
        end

        f.close
      end
    end

    # From a chunk of bits, mining it and discover frames!
    ## Algorithm
    # => Replace flags to some char
    # => Apply tokenization for this char
    # => Push to a stack the content between tokens
    # => Ever, the char token is at index zero
    # => Copy the content at next token and push it to stack, mark it with status: ok. Remove it from buffer
    # => if not at zero, a transmission error is found
    # => Copy the error at next token and push it to stack, mark it with status: erro. Remove it from buffer
    # => Remove the token
    # => Repeat it while the buffer is not empty
    def parse
      buffer = @buffered_frames.gsub(BIT_FLAG_REGEX, 'a') # reserved buffer, replace flags to a

      while buffer.length > 0
        index = buffer.index('a')
        buffer = buffer.gsub(/^a/, '') #remove first

        if index == 0
          aux = buffer.index('a')

          @stack.push( { data: buffer[0..(aux - 1)], status: 'ok' } )
          buffer = buffer[aux..-1]
        else
          @stack.push( { data: buffer[0..(index - 1)], status: 'erro' } )
          buffer = buffer[index..-1]
        end

        buffer = buffer.gsub(/^a/, '') #remove last
      end
    end
  end
end
