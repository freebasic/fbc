'' examples/manual/switches/deflng.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDeflng
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

DefLng l
Dim lNumber ' implicit: As Long

Print Len(lNumber) ' Displays 4, the number of bytes in a long.
