'' examples/manual/udt/enum.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ENUM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEnum
'' --------

Enum MyEnum
	option1 = 1
	option2
	option3
End Enum

Dim MyVar As MyEnum

MyVar = option1

Select Case MyVar
	Case option1
		Print "Option 1"
	Case option2
		Print "Option 2"
	Case option3
		Print "Option 3"
End Select
