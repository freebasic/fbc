'' examples/manual/udt/union4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'UNION'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUnion
'' --------

' Example 4: Using Nested Named Union
Type T
	Union U
		a As Short
		Type
			b1 As Byte
			b2 As Byte
		End Type
		Declare Sub proc(ByVal _b1 As Byte, ByVal _b2 As Byte)
	End Union
	m As U	
	Declare Sub proc()
End Type

Sub T.U.proc(ByVal _b1 As Byte, ByVal _b2 As Byte)
	This.b1 = _b1
	This.b2 = _b2
End Sub

Sub T.proc()
	Print This.m.b1, This.m.b2, This.m.a
End Sub

Dim x As T
x.m.proc(1, 2)
x.proc()

Sleep
