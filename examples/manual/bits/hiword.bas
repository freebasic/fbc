'' examples/manual/bits/hiword.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'HIWORD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgHiword
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
