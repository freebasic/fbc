'' examples/manual/proguide/recursion_iteration/tail_recursive_factorial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function tailRecursiveFactorial (ByVal n As Integer, ByVal result As Integer = 1) As Integer
	If (n = 0) Then                                       '' end condition
		Return result
	Else                                                  '' recursion loop
		Return tailRecursiveFactorial(n - 1, result * n)  '' tail recursive call
	End If
End Function
			
