'' examples/manual/proguide/recursion/recursivequicksort.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Recursion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

Dim Shared As UByte t(99)

Sub recursiveQuicksort (ByVal L As Integer, ByVal R As Integer)
	Dim As Integer pivot = L, I = L, J = R
	Do
		If t(I) >= t(J) Then
			Swap t(I), t(J)
			pivot = L + R - pivot
		End If
		If pivot = L Then
			J = J - 1
		Else
			I = I + 1
		End If
	Loop Until I = J
	If L < I - 1 Then
		recursiveQuicksort(L, I - 1)
	End If
	If R > J + 1 Then
		recursiveQuicksort(J + 1, R)
	End If
End Sub

Randomize
For I As Integer = LBound(t) To UBound(t)
	t(i) = Int(Rnd * 256)
Next I

Print "raw memory:"
For K As Integer = LBound(t) To UBound(t)
	Print Using "####"; t(K);
Next K
Print

recursiveQuicksort(LBound(t), UBound(t))

Print "sorted memory:"
For K As Integer = LBound(t) To UBound(t)
	Print Using "####"; t(K);
Next K
Print

Sleep
