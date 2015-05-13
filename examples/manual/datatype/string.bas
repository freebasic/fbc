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

''Reserving space for a string
Var mybigstring = Space(1024)

''Explicitly destroying a string
mybigstring = ""

''Const qualifier preventing string from being modified
Sub silly_print( ByRef printme As Const String )
	Print ".o0( " & printme & " )0o."
	'next line will cause error if uncommented
	'printme = "silly printed"
End Sub

silly_print( "Hello FreeBASIC!" )

'' Fixed-length
Dim c As String * 32
c = "Hello World"
