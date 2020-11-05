'' examples/manual/proguide/recursion_iteration/recursive_fibonacci.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
			
