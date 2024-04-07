'' examples/manual/proguide/recursion/recursivecombination.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Recursion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

Function recursiveCombination (ByVal n As UInteger, ByVal p As UInteger) As LongInt
	If p = 0 Or p = n Then
		Return 1
	Else
		Return recursiveCombination(n - 1, p) + recursiveCombination(n - 1, p - 1)
	End If
End Function

Dim As UInteger n = 10
For I As UInteger = 0 To n
	For J As UInteger = 0 To I
		Locate , 6 * J + 3 * (n - I) + 3
		Print recursiveCombination(I, J);
	Next J
	Print
Next I

Sleep
