'' examples/manual/switches/defdbl.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDefdbl
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

DefDbl a-d
Dim aNum 'implicit: As Double

Print Len(aNum) ' Prints 8, the number of bytes in a double.
