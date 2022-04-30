'' examples/manual/operator/shr-assign.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Shr= (Shift right and Assign)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCombineShiftRight
'' --------

Dim i As Integer
i = &b00011000   '' = 24
i Shr= 3         '' = i\2^3
'' Result: 11          3            3
Print Bin(i), i, 24\2^3
Sleep
