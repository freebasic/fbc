'' examples/manual/hardware/lpos.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLpos
'' --------

' compile with -lang fblite or qb

#lang "fblite"

Dim test As String = "LPrint Example test"

Print "Sending '" + test + "' to LPT1 (default)"
LPrint test
Print "LPT1 last recieved " + Str(LPOS(1)) + " characters"
Print "String sent was " + Str(Len(test)) + " characters long"

Sleep
