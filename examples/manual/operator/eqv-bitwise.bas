'' examples/manual/operator/eqv-bitwise.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator EQV (Equivalence)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpEqv
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101, c
c = a Eqv b '' c = &b10011001
