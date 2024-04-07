'' examples/manual/strings/rset.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RSET'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRset
'' --------

Dim buffer As String
buffer = Space(10)
RSet buffer, "91.5"
Print "-[" & buffer & "]-"
