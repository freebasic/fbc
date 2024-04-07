'' examples/manual/datatype/subptr2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SUB Pointer'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSubPtr
'' --------

Sub s0 ()
  Print "'s0 ()'"
End Sub

Sub s1 (ByVal I As Integer)
  Print "'s1 (Byval As Integer)'", I
End Sub

Sub s2 (ByRef S As String, ByVal D As Double)
  Print "'s2 (Byref As String, Byval As Double)'", S, D
End Sub

Dim s0_ptr As Sub () = @s0
Dim s1_ptr As Sub (ByVal I As Integer) = @s1
Dim s2_ptr As Sub (ByRef S As String, ByVal D As Double) = @s2

s0_ptr()
s1_ptr(3)
s2_ptr("PI", 3.14)
