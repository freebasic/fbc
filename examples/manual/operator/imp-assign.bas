'' examples/manual/operator/imp-assign.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator IMP= (Implication and Assign)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineImp
'' --------

Dim As UByte a = &b00110011
Dim As UByte b = &b01010101
a Imp= b
'' Result    a = &b11011101
Print Bin(a)
