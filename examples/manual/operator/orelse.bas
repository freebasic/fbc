'' examples/manual/operator/orelse.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator ORELSE (Short Circuit Inclusive Disjunction)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpOrElse
'' --------

'' Using the ORELSE operator to test
'' if a value is out of range

Dim As Integer n
Input "Enter a number between 1 and 10: ", n

Function test(ByVal n As Integer) As Integer
	Print "expression evaluated"
	Return n
End Function

'' print value only if n is in range [1, 10]
If test(n) < 1 OrElse test(n) > 10 Then  '' if n < 1, second expression is not evaluated
	Print "   => out of range"
Else
	Print "   => n ="; n
End If
Sleep
