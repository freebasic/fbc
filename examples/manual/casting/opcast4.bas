'' examples/manual/casting/opcast4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator CAST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCast
'' --------

Type UDT2
  Dim As Integer I2
End Type

Type UDT1
  Dim As Integer I1
  Declare Operator Cast () As UDT2
End Type

Operator UDT1.Cast () As UDT2
  Print "UDT1.Cast() As UDT2",,
  Dim As UDT2 u
  u.I2 = This.I1
  Return u
End Operator


Dim As UDT1 u1

u1.I1 = 123
Dim As UDT2 u2 = u1  '' implicit conversion by compiler using the defined "UDT1.Cast() As UDT2" operator
Print u2.I2
Print

u1.I1 = 456
u2 = u1              '' implicit conversion by compiler using the defined "UDT1.Cast() As UDT2" operator
Print u2.I2
Print

Sleep
	
