'' examples/manual/casting/opcast3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator CAST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCast
'' --------

Type _UDT1 As UDT1

Type UDT2
  Dim As Integer I2
  Declare Constructor ()
  Declare Constructor (ByRef u As _UDT1)
  Declare Operator Let (ByRef u As _UDT1)
End Type

Constructor UDT2 ()
End Constructor

Type UDT1
  Dim As Integer I1
End Type

Constructor UDT2 (ByRef u As UDT1)
  Print "UDT2.Constructor(Byref As UDT1)",
  This.I2 = u.I1
End Constructor

Operator UDT2.Let (ByRef u As UDT1)
  Print "UDT2.Let(Byref As UDT1)",,
  This.I2 = u.I1
End Operator


Dim As UDT1 u1

u1.I1 = 123
Dim As UDT2 u2 = u1  '' implicit conversion by compiler using the defined "UDT2.Constructor(Byref As UDT1)"
Print u2.I2
Print

u1.I1 = 456
u2 = u1              '' implicit conversion by compiler using the defined "UDT2.Let(Byref As UDT1)" operator
Print u2.I2
Print

Sleep
	
