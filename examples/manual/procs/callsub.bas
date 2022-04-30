'' examples/manual/procs/callsub.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'CALL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCall
'' --------

'' Compile with -lang qb or -lang fblite

#lang "fblite"

Declare Sub foobar(ByVal x As Integer, ByVal y As Integer)
Call foobar(35, 42)

Sub foobar(ByVal x As Integer, ByVal y As Integer)
Print x; y
End Sub
