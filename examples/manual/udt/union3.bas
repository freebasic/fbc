'' examples/manual/udt/union3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UNION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUnion
'' --------

' Example 3.
' Define a simple union.
Union AUnion
	a As UByte
	b As UInteger
End Union
' Define a composite type with an unnamed union.
Type CompType
	s As String * 20
	ui As UByte 'Flag to tell us what to use in union.
	Union
		au As UByte
		bu As UInteger
	End Union
End Type

' Flags to let us know what to use in union,
' because it's relevant to only use a single element of a union at a given time.
Const IsInteger = 1
Const IsUByte = 2

Dim MyUnion As AUnion
Dim MyComposite As CompType

' Only one field within the union is set, without choice criterion.
MyUnion.a = 128

MyComposite.s = "Type + Union"
MyComposite.ui = IsInteger ' Tells us this is an integer union.
MyComposite.bu = 1500      ' Field set according to the above flag.

Print "Simple Union: ";MyUnion.a

Print MyComposite.s & ": ";
If MyComposite.ui = IsInteger Then
	Print MyComposite.bu
ElseIf MyComposite.ui = IsUByte Then
	Print MyComposite.au
Else
	Print "Unknown Type."
End If
Print

Sleep
