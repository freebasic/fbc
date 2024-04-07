'' examples/manual/proguide/conditional_compilation.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Conditional Compilation'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgConditionalCompilation
'' --------

Function recursiveFactorial (ByVal n As Integer) As Integer
	If (n = 0) Then                         '' end condition
		#if __FB_DEBUG__ <> 0
			Print "end of recursion and result:";
		#endif
		Return 1
	Else                                    '' recursion loop
		#if __FB_DEBUG__ <> 0
			Print "multiply by: " & n
		#endif
	  Return n * recursiveFactorial(n - 1)  '' recursive call
	End If
End Function

Print recursiveFactorial(5)

Sleep
		
