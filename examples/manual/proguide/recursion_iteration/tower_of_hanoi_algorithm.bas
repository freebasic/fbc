'' examples/manual/proguide/recursion_iteration/tower_of_hanoi_algorithm.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Sub recursiveHanoi (ByVal n As Integer, ByVal departure As String, ByVal middle As String, ByVal arrival As String)
	If n > 0 Then
		recursiveHanoi(n - 1, departure, arrival, middle)
		Print "  move one disk from " & departure & " to " & arrival
		recursiveHanoi(n -1 , middle, departure, arrival)
	End If
End Sub

Sub finalRecursiveHanoi (ByVal n As Integer, ByVal departure As String, ByVal middle As String, ByVal arrival As String, ByVal dep As String = "", ByVal arr As String = "")
	If dep <> "" Then Print "  move one disk from " & dep & " to " & arr
	If n > 0 Then
		finalRecursiveHanoi(n - 1, departure, arrival, middle, "")
		finalRecursiveHanoi(n - 1, middle, departure, arrival, departure, arrival)
	End If
End Sub

#include "DynamicUserStackTypeCreateMacro.bi"
DynamicUserStackTypeCreate(DynamicUserStackTypeForString, String)

Sub translationToIterativeHanoi (ByVal n As Integer, ByVal departure As String, ByVal middle As String, ByVal arrival As String)
	Dim As String dep = "", arr = ""
	Dim As DynamicUserStackTypeForString S
	S.push = Str(n) : S.push = departure : S.push = middle : S.push = arrival : S.push = dep : S.push = arr
	While S.used > 0
		arr = S.pop : dep = S.pop : arrival = S.pop : middle = S.pop : departure = S.pop : n = Val(S.pop)
		If dep <> "" Then Print "  move one disk from " & dep & " to " & arr
		If n > 0 Then
			S.push = Str(n - 1) : S.push = middle : S.push = departure : S.push = arrival : S.push = departure : S.push = arrival
			S.push = Str(n - 1) : S.push = departure : S.push = arrival : S.push = middle : S.push = "" : S.push = ""
		End If
	Wend
End Sub



Print "recursive tower of Hanoi:"
recursiveHanoi(3, "A", "B", "C")
Print

Print "final recursive tower of Hanoi:"
finalRecursiveHanoi(3, "A", "B", "C")
Print

Print "iterative tower of Hanoi:"
translationToIterativeHanoi(3, "A", "B", "C")
Print

Sleep
			
