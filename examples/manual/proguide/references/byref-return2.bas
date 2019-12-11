'' examples/manual/proguide/references/byref-return2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Declare Function transitbyref( ByRef _s As String ) ByRef As String

Dim As String s

s = "abcd"
Print s

'' the enclosing parentheses are required here.
( transitbyref( s ) ) = transitbyref( s ) & "efgh"
Print s

'' the enclosing parentheses are not required here.
transitbyref( s ) => transitbyref( s ) & "ijkl"
Print s

Sleep

Function transitbyref( ByRef _s As String ) ByRef As String
	'' This var-len string will transit by reference (input and output), no copy will be created.
	Return _s
End Function
				
