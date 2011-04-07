'' examples/manual/proguide/errors/on-error.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgErrorHandling
'' --------

'' Compile with "-lang fblite" and "-exx"

#lang "fblite"

On Error Goto FAILED
Open "xzxwz.zwz" For Input As #1
On Error Goto 0
Sleep
End

FAILED:
Dim As Integer e = Err
Print e
Sleep
End
