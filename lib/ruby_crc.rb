require_relative 'crc'
require_relative 'xorify'
require_relative 'sender'
require_relative 'receiver'

module RubyCrc
  BIT_FLAG = 0b01111110
  BIT_FLAG_STR = '01111110'
  BIT_FLAG_REGEX = /01{6}0/

  CRC_CODE = 0b10011 # crc x⁴ + x + 1
  CRC_CODE_STR = '10011' # crc x⁴ + x + 1 :string
  CRC_ESCAPE = '0'

  PAYLOAD_IN = 'entrada' # Arquivo de entrada de dados
  PAYLOAD_OUT = 'saida' # Arquivo de saida após o processamento
  FRAMES_OUT = 'transmissao' # Arquivo com os frames a serem transmitidos

  VERSION = '0.1.0'
end
