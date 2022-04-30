'' examples/manual/proguide/recursion_iteration/explicit_tail_recursive_factorial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function explicitTailRecursiveFactorial (ByVal n As Integer, ByVal result As Integer = 1) As Integer
	If (n = 0) Then                                       '' end condition
		Return result
	Else                                                  '' recursion loop
		result = result * n
		n = n - 1
		Return explicitTailRecursiveFactorial(n, result)  '' tail recursive call
	End If
End Function
			
