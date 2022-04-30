'' examples/manual/switches/defdbl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DEFDBL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDefdbl
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

DefDbl a-d
Dim aNum 'implicit: As Double

Print Len(aNum) ' Prints 8, the number of bytes in a double.
