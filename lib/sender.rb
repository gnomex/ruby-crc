module RubyCrc

  # Transmissor
  # => Calcular checksum
  # => Escape na área de dados
  # => Inserir flags
  # => Converter quadro para string e concatenar todos os quadros
  # => Salvar os quadros a serem transmitidos em arquivo
  class Sender
    def initialize
      @buffer = []
    end

    def load_payloads
      File.open(RubyCrc::PAYLOAD_IN, "r") do |f|
        f.each_line do |line|
          @buffer << line
        end
      end
    end

    def transmit
      File.open(RubyCrc::FRAMES_OUT, "w") do |f|
        f.write mount_frames
      end
    end

    def serialize

    end

    private
    def mount_frames
    end

    def flags!(payload)
    end

    def checksum!
    end
  end
end
