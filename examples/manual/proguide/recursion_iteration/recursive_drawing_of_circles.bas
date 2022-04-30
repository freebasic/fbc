'' examples/manual/proguide/recursion_iteration/recursive_drawing_of_circles.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
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

'---------------------------------------------------------------------------

#include "DynamicUserStackTypeCreateMacro.bi"
DynamicUserStackTypeCreate(DynamicUserStackTypeForInteger, Integer)

Sub recursiveToIterativeCircleStack (ByVal x As Integer, ByVal y As Integer, ByVal r As Integer)
	Dim As DynamicUserStackTypeForInteger S
	S.push = x : S.push = y : S.push = r
	Do While S.used > 0
		r = S.pop : y = S.pop : x = S.pop
		Circle (x, y), r
		If r > 16 Then
			S.push = x + r / 2 : S.push = y : S.push = r / 2
			S.push = x - r / 2 : S.push = y : S.push = r / 2
			S.push = x : S.push = y + r / 2 : S.push = r / 2
			S.push = x : S.push = y - r / 2 : S.push = r / 2
		End If
	Loop
End Sub

'---------------------------------------------------------------------------

Screen 12

Locate 2, 2
Print "recursion:"
recursiveCircle(160, 160, 150)

Locate 10, 47
Print "iteration with own storage stack:"
recursiveToIterativeCircleStack(480, 320, 150)

Sleep
				
