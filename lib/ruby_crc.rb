module RubyCrc
  BIT_FLAG = 0x3E # 0b111110

  PAYLOAD_IN = 'entrada' # Arquivo de entrada de dados
  PAYLOAD_OUT = 'saida' # Arquivo de saida após o processamento
  FRAMES_OUT = 'transmissao' # Arquivo com os frames a serem transmitidos

  CRC_CODE = 0b10011 # polinomio gerador para o crc

  VERSION = '0.0.1'
end
