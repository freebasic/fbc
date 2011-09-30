'' examples/manual/proguide/errors/err.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgErrorHandling
'' --------

Dim As Integer e
Open "xzxwz.zwz" For Input As #1
e = Err
Print e
Sleep
