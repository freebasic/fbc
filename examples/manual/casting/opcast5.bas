'' examples/manual/casting/opcast5.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator CAST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCast
'' --------

Type _UDT1 As UDT1

Type UDT2
  Dim As Integer I2
  Declare Operator Let (ByRef u As _UDT1)
End Type

Type UDT1
  Dim As Integer I1
  Declare Operator Cast () As UDT2
End Type

Operator UDT1.Cast () As UDT2
  Print "UDT1.Cast() As UDT2"
  Return This                       '' implicit conversion by compiler using the defined "UDT2.Let(Byref As UDT1)" operator
End Operator

Operator UDT2.Let (ByRef u As UDT1)
  Print "UDT2.Let(Byref As UDT1)"
  This.I2 = u.I1
End Operator


Dim As UDT1 u1
u1.I1 = 123

Print Cast(UDT2, u1).I2

Sleep
	
