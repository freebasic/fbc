'' examples/manual/proguide/recursion_iteration/explicit_tail_recursive_fibonacci.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function explicitTailRecursiveFibonacci (ByVal n As UInteger, ByVal a As UInteger = 0, ByVal b As UInteger = 1) As LongInt
	If n <= 1 Then                                      '' end condition
		Return b * n
	Else                                                '' recursion loop
		n = n - 1
		Swap a, b
		b = b + a
		Return explicitTailRecursiveFibonacci(n, a, b)  '' tail recursive call
	End If
End Function
			
