'' examples/manual/proguide/recursion/recursivecircle.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Recursion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

Sub recursiveCircle (ByVal x As Integer, ByVal y As Integer, ByVal r As Integer)
	Circle (x, y), r
	If r > 16 Then
		recursiveCircle(x + r / 2, y, r / 2)
		recursiveCircle(x - r / 2, y, r / 2)
		recursiveCircle(x, y + r / 2, r / 2)
		recursiveCircle(x, y - r / 2, r / 2)
	End If
End Sub

Screen 12

Locate 2, 2
recursiveCircle(160, 160, 150)

Sleep
