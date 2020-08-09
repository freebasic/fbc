'' examples/manual/proguide/recursion_iteration/iterative_factorial.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
				
