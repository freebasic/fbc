'' examples/manual/control/return2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RETURN (from procedure)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgReturn
'' --------

'' Return from function

Type rational              '' simple rational number type
	numerator As Integer
	denominator As Integer
End Type

'' multiplies two rational types
Function rational_multiply( r1 As rational, r2 As rational ) As rational

	Dim r As rational
	'' multiply the divisors ...
	r.numerator   = r1.numerator   * r2.numerator
	r.denominator = r1.denominator * r2.denominator

	'' ... and return the result
	Return r

End Function

Dim As rational r1 = ( 6, 105 )   '' define some rationals r1 and r2
Dim As rational r2 = ( 70, 4 )
Dim As rational r3

r3 = rational_multiply( r1, r2 )  '' multiply and store the result in r3

'' display the expression
Print r1.numerator & "/" & r1.denominator; " * ";
Print r2.numerator & "/" & r2.denominator; " = ";
Print r3.numerator & "/" & r3.denominator
