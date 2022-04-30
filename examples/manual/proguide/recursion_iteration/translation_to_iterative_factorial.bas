'' examples/manual/proguide/recursion_iteration/translation_to_iterative_factorial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function translationToIterativeFactorial (ByVal n As Integer, ByVal result As Integer = 1) As Integer
	begin:
	If (n = 0) Then          '' end condition
		Return result
	Else                     '' iteration loop
		result = result * n  '' iterative accumulation
		n = n - 1
		Goto begin           '' iterative jump
	End If
End Function
			
