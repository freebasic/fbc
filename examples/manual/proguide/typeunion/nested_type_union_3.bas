'' examples/manual/proguide/typeunion/nested_type_union_3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type (UDT/Alias/Temporary) and Union'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeUnion
'' --------

Type UDT1
	Private:
		Dim As Integer I1 = 123
		Type UDT2
			Private:
				Dim As Integer I2 = 456
			Public:
				Declare Function returnI2() As Integer
		End Type
	Public:
		Type UDT3
			Private:
				Dim As Integer I3 = 789
			Public:
				Declare Function returnI3() As Integer
		End Type
		Declare Function returnI1() As Integer
		Dim As UDT2 t2
		Dim As UDT3 t3
End Type

Function UDT1.returnI1() As Integer
	Return This.I1
End Function

Function UDT1.UDT2.returnI2() As Integer
	Return This.I2
End Function

Function UDT1.UDT3.returnI3() As Integer
	Return This.I3
End Function

Dim As UDT1 t11

'Print t11.I1            '' error 202: Illegal member access
						 ''    I1 is in the private section of UDT1

Print t11.returnI1()     '' OK, returnI1() is in the public section of UDT1

'Print t11.t2.I2         '' error 202: Illegal member access
						 ''    t2 is in the public section of UDT1, but I2 is in the private section of UDT2

Print t11.t2.returnI2()  '' OK, t2 is in the public section of UDT1, and returnI2() is in the public section of UDT2

'Print t11.t3.I3         '' error 202: Illegal member access
						 ''    t3 is in the public section of UDT1, but I3 is in the private section of UDT3

Print t11.t3.returnI3()  '' OK, t3 is in the public section of UDT1, and returnI3() is in the public section of UDT3
Print

'Dim As UDT1.UDT2 t21    '' error 202: Illegal member access
						 ''    UDT2 is in the private section of UDT1

Dim As UDT1.UDT3 t31     '' OK, UDT3 is in the public section of UDT1

'Print t31.I3            '' error 202: Illegal member access
						 ''    I3 is in the private section of UDT3

Print t31.returnI3()     '' OK, returnI3() is in the public section of UDT3

Sleep
