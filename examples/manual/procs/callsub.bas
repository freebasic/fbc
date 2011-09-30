'' examples/manual/procs/callsub.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCall
'' --------

'' Compile with -lang qb or -lang fblite

#lang "fblite"

Declare Sub foobar(ByVal x As Integer, ByVal y As Integer)
Call foobar(35, 42)

Sub foobar(ByVal x As Integer, ByVal y As Integer)
Print x; y
End Sub
