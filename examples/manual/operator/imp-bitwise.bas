'' examples/manual/operator/imp-bitwise.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Imp (Implication)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpImp
'' --------

Dim As UByte a, b, c
a = &b00001111
b = &b01010101
c = a Imp b '' c = &b11110101
