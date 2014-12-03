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
      @crc = CRC.new
      @buffered_frames = ""
      @stack = Array.new
      @frames = Array.new
      # load_frames
    end

    def load_frames
      File.open(RubyCrc::FRAMES_OUT, "r") do |f|
        f.each_line do |line|
          @buffered_frames << line.chomp unless line.empty?
          # @buffered_frames << line unless line.empty?
        end
      end
    end

    def umount_frames
      @stack.each do |item|
        if item[:status] == 'ok'
          checksum = @crc.undo( item[:data] )
          item[:checksum] = checksum

          unless checksum.match(/^0{4}/)
            item[:status] = 'erro'
          end
        end

        @frames.push( item )
      end
    end

    def transmit
      if @frames.any? # check is exists something on buffer
        f = File.open(RubyCrc::PAYLOAD_OUT, "w")

        @frames.each do |frame|
          f.puts frame.to_a.flatten.join(' - ')
        end

        f.close
      end
    end

    def parse
      puts "buffer:[ #{@buffered_frames}"

      buffer = @buffered_frames.gsub(BIT_FLAG_REGEX, 'a') # reserved buffer, replace flags to a

      puts "buffer:[ #{ buffer }"

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
