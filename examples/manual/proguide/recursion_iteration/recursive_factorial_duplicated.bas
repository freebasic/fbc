'' examples/manual/proguide/recursion_iteration/recursive_factorial_duplicated.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
			
