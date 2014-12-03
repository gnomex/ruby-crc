module RubyCrc

  # Transmissor
  # => Calcular checksum
  # => Escape na área de dados
  # => Inserir flags
  # => Converter quadro para string e concatenar todos os quadros
  # => Salvar os quadros a serem transmitidos em arquivo
  class Sender
    attr_reader :buffer

    def initialize
      @buffer = [] # initialize the buffer
      load_payloads # load payloads from file to buffer
    end

    def transmit
      if @buffer.any? # check is exists something on buffer
        File.open(RubyCrc::FRAMES_OUT, "w") do |f|
          f.write mount_frames
        end
      end
    end

    def serialize
    end

    private
    def load_payloads
      File.open(RubyCrc::PAYLOAD_IN, "r") do |f|
        f.each_line do |line|
          @buffer << line
        end
      end
    end

    def mount_frames
    end

    def flags!(payload)
      [RubyCrc::BIT_FLAG_STR, payload, RubyCrc::BIT_FLAG_STR].join('')
    end

    def checksum(word)
    end
  end
end
