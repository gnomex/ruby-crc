# Ruby-crc

Cyclic Redundancy Check algorithm bit a bit

> Brushing bits! But the bits are strings

PS: Academic Stuff

## Go!

1. Clone the source
2. go to project path (`cd ~path~/ruby-crc/`)
3. run bundler (`bundle install`)
4. go to lib path (`cd lib/`)
5. use rake

```ruby
rake -T
rake pack     # Trasmissor
rake unpack   # Receiver
rake version  # Print module version
```

Pack is the transmiter, he will read the file 'entrada' and run CRC algorithms. The out is the file 'transmissao', with a chunk os bits representing frames.

```ruby
rake pack
Instance: #<RubyCrc::Sender:0x000000012b0498 @crc=#<RubyCrc::CRC:0x000000012b0448 @xorify=#<RubyCrc::Xorify:0x000000012b0420 @inc=5>>, @buffer=[], @frames=[]>
Done.
```

Unpack is the receiver, he will read the file 'transmission' and mining it, building the frames, check errors and report is checksum is ok, the final log is the file 'saida'

```ruby
rake unpack
Instance: #<RubyCrc::Receiver:0x000000027243c0 @crc=#<RubyCrc::CRC:0x00000002724348 @xorify=#<RubyCrc::Xorify:0x00000002724320 @inc=5>>, @buffered_frames="", @stack=[], @frames=[]>
Done.

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
