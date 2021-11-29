'' examples/manual/datatype/string-varlen.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
