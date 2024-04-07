'' examples/manual/operator/not-equal.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator <> (Not equal)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNotEqual
'' --------

Dim As String a = "hello", b = "world"
Dim As Integer i = 10, j = i

If (a <> b) Then
  Print a & " does not equal " & b
End If

If (i <> j) Then
  Print "error: " & i & " does not equal " & j
End If
