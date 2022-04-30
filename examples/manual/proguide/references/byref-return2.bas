'' examples/manual/proguide/references/byref-return2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using References'
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
				
