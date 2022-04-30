'' examples/manual/proguide/recursion_iteration/recursive_fibonacci.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function recursiveFibonacci (ByVal n As UInteger) As LongInt
	If n = 0 Or n = 1 Then                                            '' end condition
		Return n
	Else                                                              '' recursion loop
		Return recursiveFibonacci(n - 1) + recursiveFibonacci(n - 2)  '' recursive call
	End If
End Function
			
