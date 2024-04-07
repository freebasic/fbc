'' examples/manual/switches/deflng.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DEFLNG'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeflng
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

DefLng l
Dim lNumber ' implicit: As Long

Print Len(lNumber) ' Displays 4, the number of bytes in a long.
