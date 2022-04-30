'' examples/manual/proguide/recursion_iteration/better_translation_to_iterative_factorial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Replace Recursion with Iteration'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursionIteration
'' --------

Function  betterTranslationToIterativeFactorial (ByVal n As Integer) As Integer
	Dim As Integer result = 1
	While Not (n = 0)        '' end condition of iterative loop
		result = result * n  '' iterative accumulation
		n = n - 1
	Wend
	Return result
End Function
			
