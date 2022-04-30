'' examples/manual/proguide/recursion/iterativefactorial.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Recursion'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

'' The code body of the iterative function is defined by using the iterative definition of the factorial function:
''    Case (n = 0) : factorial(0) = 1
''    Case (n > 0) : factorial(n) = (1) * ..... * (n - 2) * (n - 1) * (n)
''    The first line allows to determine the cumulative variable initialization: 'result = 1'
''    The second line allows to determine the statement syntax which accumulates: 'result = result * I'

Function iterativeFactorial (ByVal n As Integer) As Integer
	Dim As Integer result = 1  '' variable initialization
	For I As Integer = 1 To n  '' iteration loop
		result = result * I    '' iterative accumulation
	Next I
	Return result
End Function

Print iterativeFactorial(6)

Sleep
