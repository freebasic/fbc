'' examples/manual/datatype/string-varlen.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgString
'' --------

'' Variable length
Dim a As String

a = "Hello"
Print a

a += ", world!"
Print a

Dim As String b = "Welcome to FreeBASIC"
Print b + "! " + a
