'' examples/manual/bits/hibyte.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgHibyte
'' --------

Dim N As UInteger

'Note there are 16 bits
N = &b1010101110000001
Print "N is                                       "; N
Print "The binary representation of N is          "; Bin(N)
Print "The most significant byte (MSB) of N is    "; HiByte(N)
Print "The least significant byte (LSB) of N is   "; LoByte(N)
Print "The binary representation of the MSB is    "; Bin(HiByte(N))
Print "The binary representation of the LSB is    "; Bin(LoByte(N))
Sleep
