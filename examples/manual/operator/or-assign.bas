'' examples/manual/operator/or-assign.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator OR= (Inclusive Disjunction and Assign)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineOr
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101
a Or= b
'' Result    a = &b01110111
Print Bin(a)
