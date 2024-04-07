'' examples/manual/operator/eqv-assign.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator EQV= (Equivalence and Assign)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineEqv
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101
a Eqv= b
'' Result    a = &b10011001
Print Bin(a)
