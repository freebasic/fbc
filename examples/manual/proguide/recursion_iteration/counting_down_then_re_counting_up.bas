'' examples/manual/proguide/recursion_iteration/counting_down_then_re_counting_up.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Sub recursiveCount (ByVal n As Integer)
	If n >= 0 Then
		Print n & " ";
		If n = 0 Then Print
		recursiveCount(n - 1)
		Print n & " ";
	End If
End Sub

Sub finalRecursiveCount (ByVal n As Integer, ByVal recount As String = "")
	If recount <> "" Then
		Print recount & " ";
	Else
		If n >= 0 Then
			Print n & " ";
			If n = 0 Then Print
			finalRecursiveCount(n - 1, "")
			finalRecursiveCount(n - 1, Str(n))
		End If
	End If
End Sub

#include "DynamicUserStackTypeCreateMacro.bi"
DynamicUserStackTypeCreate(DynamicUserStackTypeForString, String)

Sub translationToIterativeCount (ByVal n As Integer)
	Dim As String recount = ""
	Dim As DynamicUserStackTypeForString S
	S.push = Str(n) : S.push = recount
	While S.used > 0
		recount = S.pop : n = Val(S.pop)
		If recount <> "" Then
			Print recount & " ";
		Else
			If n >= 0 Then
				Print n & " ";
				If n = 0 Then Print
				S.push = Str(n - 1) : S.push = Str(n)
				S.push = Str(n - 1) : S.push = ""
			End If
		End If
	Wend
End Sub



Print "recursive counting-down then re-counting up:"
recursiveCount(9)
Print
Print

Print "final recursive counting-down then re-counting up:"
finalRecursiveCount(9)
Print
Print

Print "iterative counting-down then re-counting up:"
translationToIterativeCount(9)
Print
Print

Sleep
			
