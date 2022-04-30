'' examples/manual/hardware/lpos.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LPOS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLpos
'' --------

' compile with -lang fblite or qb

#lang "fblite"

Dim test As String = "LPrint Example test"

Print "Sending '" + test + "' to LPT1 (default)"
LPrint test
Print "LPT1 last recieved " + Str(LPos(1)) + " characters"
Print "String sent was " + Str(Len(test)) + " characters long"

Sleep
