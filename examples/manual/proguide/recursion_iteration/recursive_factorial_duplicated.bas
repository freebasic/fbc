'' examples/manual/proguide/recursion_iteration/recursive_factorial_duplicated.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function recursiveFactorial (ByVal n As Integer) As Integer
	If (n = 0) Then                           '' end condition
		Return 1
	Else                                      '' recursion loop
		Return n * recursiveFactorial(n - 1)  '' recursive call
	End If
End Function
			
