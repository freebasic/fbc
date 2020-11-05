'' examples/manual/proguide/recursion_iteration/better_translation_to_iterative_factorial.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
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
			
