module RubyCrc

  # Receptor
  # => Recebe todos quadros
  # => Identificar quadros
  # => Ressincronizar quando necessário
  # => Remover flags
  # => Remover escapes
  # => Verificar checksum
  # => Gravar payload dos quadros em arquivo, separados por linha
  ## Formato do log
  # => [OK|ERRO] payload [polinônimo gerador CRC]
  class Receiver
    def initialize
      @buffered_frames = ""
      @stack = []
      load_frames
    end


    private
    def load_frames
      File.open(RubyCrc::FRAMES_OUT, "r") do |f|
        f.each_line do |line|
          @buffered_frames << line.chop unless line.empty?
        end
      end
    end

    def parse

    find a
    if index a != 0 -> chunck -> push to chunks, status: undefined
      remove and find next, if next == current + 1 -> shit!, update latest chuck to frame_error, ignore a
    else
      push to stack
      remove a
    end


      # a.gsub(BIT_FLAG_REGEX, 'a')

      # find 'a' from front of string
      # remove them
      # find next a
      # copy content and push to stack
      # remove a

      # index('a')
      # gsub(/^.a/)

      # @stack.push
      # @stack.pop
    end

    def resync

    end
  end
end
