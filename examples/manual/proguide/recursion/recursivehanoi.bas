'' examples/manual/proguide/recursion/recursivehanoi.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

'' For this example, the two recursive calls are at the end of executed code block,
''   but separated by an instruction line and there is an order constraint.

Sub recursiveHanoi (ByVal n As Integer, ByVal departure As String, ByVal middle As String, ByVal arrival As String)
	If n > 0 Then
		recursiveHanoi(n - 1, departure, arrival, middle)
		Print "  move one disk from " & departure & " to " & arrival
		recursiveHanoi(n -1 , middle, departure, arrival)
	End If
End Sub

recursiveHanoi(3, "A", "B", "C")

Sleep
