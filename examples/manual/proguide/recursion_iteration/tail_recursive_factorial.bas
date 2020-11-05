'' examples/manual/proguide/recursion_iteration/tail_recursive_factorial.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
			
