'' examples/manual/proguide/recursion/tailrecursivefactorial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Recursion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

Function tailRecursiveFactorial (ByVal n As Integer, ByVal result As Integer = 1) As Integer
	If (n = 0) Then                                       '' end condition
		Return result
	Else                                                  '' recursion loop
		Return tailRecursiveFactorial(n - 1, result * n)  '' tail recursive call
	End If
End Function

Print tailRecursiveFactorial(6)

Sleep
		
