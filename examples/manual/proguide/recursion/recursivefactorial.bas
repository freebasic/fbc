'' examples/manual/proguide/recursion/recursivefactorial.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgRecursion
'' --------

'' The code body of the recursive function is defined by using the recursive definition of the factorial function:
''    Case (n = 0) : factorial(0) = 1
''    Case (n > 0) : factorial(n) = n * factorial(n-1)
''    The first line allows to determine the end condition: 'If (n = 0) Then Return 1'
''    The second line allows to determine the statement syntax which calls the function itself: 'Return n * factorial(n - 1)'

Function recursiveFactorial (ByVal n As Integer) As Integer
	If (n = 0) Then                           '' end condition
		Return 1
	Else                                      '' recursion loop
		Return n * recursiveFactorial(n - 1)  '' recursive call
	End If
End Function

Print recursiveFactorial(6)

Sleep
