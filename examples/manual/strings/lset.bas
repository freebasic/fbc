'' examples/manual/strings/lset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LSET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLset
'' --------

Dim buffer As String
buffer = Space(10)
LSet buffer, "91.5"
Print "-[" & buffer & "]-"
