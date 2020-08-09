'' examples/manual/bits/bitreset.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBitreset
'' --------

Print Bin(BitReset(&b10101, 2))
Print BitReset(5,0)
Print Hex(BitReset(&h8000000000000001,63))
