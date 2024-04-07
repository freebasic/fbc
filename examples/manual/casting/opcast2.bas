'' examples/manual/casting/opcast2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator CAST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCast
'' --------

Type UDT
  As Integer I
  Declare Constructor ()
  Declare Constructor (ByVal I0 As Integer)
  Declare Operator Let (ByVal I0 As Integer)
  Declare Operator Cast () ByRef As Integer
End Type

Constructor UDT ()
End Constructor

Constructor UDT (ByVal I0 As Integer)
  Print "UDT.Constructor(Byval As Integer)",
  This.I = I0
End Constructor

Operator UDT.Let (ByVal I0 As Integer)
  Print "UDT.Let(Byval As Integer)",,
  This.I = I0
End Operator

Operator UDT.Cast () ByRef As Integer
  Print "UDT.Cast() Byref As Integer",,
  Return This.I
End Operator


Dim As UDT u

'u = Cast(UDT, 12)     '' unsupported - error 20: Type mismatch
u = UDT(34)            '' explicit conversion using the defined "Constructor(Byval As Integer)"
Print u.I
Print

u = 56                 '' implicit conversion by compiler using the defined "Let(Byval As Integer)" operator
Print u.I
Print

Cast(Integer, u) = 78  '' explicit conversion using the defined "Cast() Byref As Integer" operator with byref return
Print u.I
Print

Sleep
	
