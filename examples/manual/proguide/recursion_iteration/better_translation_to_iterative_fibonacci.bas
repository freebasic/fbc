'' examples/manual/proguide/recursion_iteration/better_translation_to_iterative_fibonacci.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function betterTranslationToIterativeFibonacci (ByVal n As UInteger) As LongInt
	Dim As UInteger a = 0, b = 1
	While Not (n <= 1)  '' end condition of iterative loop
		n = n - 1
		Swap a, b
		b = b + a
	Wend
	Return b * n
End Function
			
