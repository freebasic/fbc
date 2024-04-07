'' examples/manual/proguide/recursion_iteration/ackermann.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
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

#include "DynamicUserStackTypeCreateMacro.bi"
DynamicUserStackTypeCreate(DynamicUserStackTypeForInteger, Integer)

Function iterativeAckermann (ByVal m As Integer, ByVal n As Integer) As Integer
	Dim As DynamicUserStackTypeForInteger Sm, Sn
	Sm.push = m : Sn.push = n
	While Sm.used > 0
		m = Sm.pop : n = Sn.pop
		If m = 0 Then
			Sn.push = n + 1                                      ' Return n + 1 (and because of nested call)
		Else
			If n = 0 Then
				Sm.push = m - 1 : Sn.push = 1                    ' Return Ackermann(m - 1, 1)
			Else
				Sm.push = m - 1 : Sm.push = m : Sn.push = n - 1  ' Return Ackermann(m - 1, Ackermann(m, n - 1))
			End If
		End If
	Wend
	Return Sn.pop                                                ' (because of Sn.push = n + 1)
End Function



Print recursiveAckermann(3, 0), recursiveAckermann(3, 1), recursiveAckermann(3, 2), recursiveAckermann(3, 3), recursiveAckermann(3, 4)
Print iterativeAckermann(3, 0), iterativeAckermann(3, 1), iterativeAckermann(3, 2), iterativeAckermann(3, 3), iterativeAckermann(3, 4)

Sleep
			
