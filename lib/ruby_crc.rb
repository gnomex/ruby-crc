require_relative 'crc'
require_relative 'xorify'
require_relative 'sender'
require_relative 'receiver'

module RubyCrc
  BIT_FLAG = 0b00111110
  BIT_FLAG_STR = '111110'

  PAYLOAD_IN = 'entrada' # Arquivo de entrada de dados
  PAYLOAD_OUT = 'saida' # Arquivo de saida após o processamento
  FRAMES_OUT = 'transmissao' # Arquivo com os frames a serem transmitidos

  VERSION = '0.0.1'
end
