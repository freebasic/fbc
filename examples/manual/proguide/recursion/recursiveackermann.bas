'' examples/manual/proguide/recursion/recursiveackermann.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

Function recursiveAckermann (ByVal m As Integer, ByVal n As Integer) As Integer
	If m = 0 Then
		Return n + 1
	Else
		If n = 0 Then
			Return recursiveAckermann(m - 1, 1)
		Else
			Return recursiveAckermann(m - 1, recursiveAckermann(m, n - 1))
		End If
	End If
End Function

Print recursiveAckermann(3, 0), recursiveAckermann(3, 1), recursiveAckermann(3, 2), recursiveAckermann(3, 3), recursiveAckermann(3, 4)

Sleep
