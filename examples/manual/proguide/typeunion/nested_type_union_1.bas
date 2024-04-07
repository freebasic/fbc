'' examples/manual/proguide/typeunion/nested_type_union_1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type (UDT/Alias/Temporary) and Union'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeUnion
'' --------

Type T  '' named
	Union  '' anonymous
		Dim a As Short
		Type  '' anonymous
			Dim b1 As Byte
			Dim b2 As Byte
		End Type
	End Union
	Declare Sub proc()
End Type

Sub T.proc()
	b1 = 1
	b2 = 2
	Print b1, b2, a
End Sub

Dim x As T
x.proc()

Sleep
