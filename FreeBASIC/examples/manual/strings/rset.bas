'' examples/manual/strings/rset.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRset
'' --------

Dim buffer As String
buffer = Space(10)
RSet buffer, "91.5"
Print "-[" & buffer & "]-"
