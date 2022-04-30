'' examples/manual/casting/opcast-ctor-oplet.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Coercion and Conversion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgDataConversion
'' --------

Type UDT
  Dim As Integer I
  Declare Operator Cast () As Integer
  Declare Constructor (ByVal I0 As Integer)
  Declare Operator Let (ByVal I0 As Integer)
End Type

Operator UDT.Cast () As Integer
  Return This.I
End Operator

Constructor UDT (ByVal I0 As Integer)
  This.I = I0
End Constructor

Operator UDT.Let (ByVal I0 As Integer)
  This.I = I0
End Operator

Dim As Integer J = 12
Dim As UDT u1 = UDT(J)  '' construction with explicit initialization using the defined "Constructor(Byval As Integer)" operator
Print u1.I
Dim As UDT u2 = J       '' construction with implicit initialization by compiler using the defined "Constructor(Byval As Integer)" operator
Print u2.I
Print

u1.I = 34
J = Cast(Integer, u1)  '' explicit assignment using the defined "Cast() As Integer" operator
Print J
Dim As Integer K
K = u1                 '' implicit assignment by compiler using the defined "Cast() As Integer" operator
Print K
Print

J = 56
u1 = J                 '' implicit assignment by compiler using the defined "Let(Byval As Integer)" operator
Print u1.I
Print

Sleep
