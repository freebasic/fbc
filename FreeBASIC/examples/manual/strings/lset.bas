'' examples/manual/strings/lset.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLset
'' --------

Dim buffer As String
buffer = Space(10)
LSet buffer, "91.5"
Print "-[" & buffer & "]-"
