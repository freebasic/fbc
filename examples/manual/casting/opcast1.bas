'' examples/manual/casting/opcast1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator CAST'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpCast
'' --------

Type UDT
  Dim As Integer I
  Declare Operator Cast () As Integer
  Declare Operator Cast () As String
End Type

Operator UDT.Cast () As Integer
  Print "UDT.Cast() As Integer",
  Return This.I
End Operator

Operator UDT.Cast () As String
  Print "UDT.Cast() As String",
  Return Str(This.I)
End Operator


Dim As UDT u

u.I = 12
Print Cast(Integer, u)               '' explicit conversion using the defined "Cast() As Integer" operator
Print Cast(String, u)                '' explicit conversion using the defined "Cast() As String" operator
Print u                              '' implicit conversion by compiler using the defined "Cast() As String" operator
Print

u.I = 34
Dim As Integer J = Cast(Integer, u)  '' construction with explicit initialization using the defined "Cast() As Integer" operator
Print J
Dim As Integer K = u                 '' construction with implicit initialization by compiler using the defined "Cast() As Integer" operator
Print K
Print

u.I = 56
J = Cast(Integer, u)                 '' explicit assignment using the defined "Cast() As Integer" operator
Print J
K = u                                '' implicit assignment by compiler using the defined "Cast() As Integer" operator
Print K
Print

u.I = 78
Dim As String S = Cast(String, u)    '' construction with explicit initialization using the defined "Cast() As String" operator
Print S
Dim As String G = u                  '' construction with implicit initialization by compiler using the defined "Cast() As String" operator
Print G
Print

u.I = 90
S = Cast(String, u)                  '' explicit assignment using the defined "Cast() As String" operator
Print S
G = u                                '' implicit assignment by compiler using the defined "Cast() As String" operator
Print G
Print

Sleep
	
