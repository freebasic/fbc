'' examples/manual/bits/bitset.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgBitset
'' --------

Print Bin(BitSet(&b10001,2))
Print BitSet(4, 0)
Print Hex(BitSet(1ull, 63))
