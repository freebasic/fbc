'' examples/manual/datatype/string.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgString
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

'' Variable-length
Dim a As String
a = "Hello"

'' Or
Dim b$
b$ = "World"

'' Fixed-length
Dim c As String * 32
c = "Hello World"
