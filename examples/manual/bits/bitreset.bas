'' examples/manual/bits/bitreset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BITRESET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBitreset
'' --------

Print Bin(BitReset(&b10101, 2))
Print BitReset(5,0)
Print Hex(BitReset(&h8000000000000001,63))
