'' examples/manual/proguide/recursion_iteration/iterative_factorial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function iterativeFactorial (ByVal n As Integer) As Integer
	Dim As Integer result = 1  '' variable initialization
	For I As Integer = 1 To n  '' iteration loop
		result = result * I    '' iterative accumulation
	Next I
	Return result
End Function
				
