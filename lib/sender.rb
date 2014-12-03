module RubyCrc

  # Transmissor
  # => Calcular checksum
  # => Escape na área de dados
  # => Inserir flags
  # => Converter quadro para string e concatenar todos os quadros
  # => Salvar os quadros a serem transmitidos em arquivo
  class Sender
    attr_reader :buffer, :crc

    def initialize
      @crc = CRC.new
      @buffer = [] # initialize the buffer
      @frames = []
      # load_payloads # load payloads from file to buffer
    end

    def build
      mount_frames

      transmit
    end

    def transmit
      if @frames.any? # check is exists something on buffer
        File.open(RubyCrc::FRAMES_OUT, "w") do |f|
          f.write @frames.join('')
        end
      end
    end

    def load_payloads
      File.open(RubyCrc::PAYLOAD_IN, "r") do |f|
        f.each_line do |line|
          @buffer << line.chop unless line.empty?
        end
      end
    end
    private

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
