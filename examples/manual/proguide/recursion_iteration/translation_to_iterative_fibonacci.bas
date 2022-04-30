'' examples/manual/proguide/recursion_iteration/translation_to_iterative_fibonacci.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function translationToIterativeFibonacci (ByVal n As UInteger, ByVal a As UInteger = 0, ByVal b As UInteger = 1) As LongInt
	begin:
	If n <= 1 Then    '' end condition
		Return b * n
	Else              '' iteration loopp
		n = n - 1
		Swap a, b
		b = b + a
		Goto begin    '' iterative jump
	End If
End Function
			
