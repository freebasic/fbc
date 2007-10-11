'' examples/manual/bits/loword.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgloword
'' --------

Dim N As UInteger

'Note there are 32 bits
N = &b10000000000000011111111111111111

Print "N is                                       "; N
Print "The binary representation of N is          "; Bin(N)
Print "The most significant word (MSW) of N is    "; HiWord(N)
Print "The least significant word (LSW) of N is   "; LoWord(N)
Print "The binary representation of the MSW is    "; Bin(HiWord(N))
Print "The binary representation of the LSW is    "; Bin(LoWord(N))

Sleep
