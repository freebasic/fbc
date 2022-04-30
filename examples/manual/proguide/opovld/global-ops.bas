'' examples/manual/proguide/opovld/global-ops.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Overloading'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgOperatorOverloading
'' --------

Type Rational
	As Integer numerator, denominator
End Type

Operator - (ByRef rhs As Rational) As Rational
	Return Type(-rhs.numerator, rhs.denominator)
End Operator

Operator * (ByRef lhs As Rational, ByRef rhs As Rational) As Rational
	Return Type(lhs.numerator * rhs.numerator, _
		lhs.denominator * rhs.denominator)
End Operator

Dim As Rational r1 = (2, 3), r2 = (3, 4)
Dim As Rational r3 = -(r1 * r2)
Print r3.numerator & "/" & r3.denominator
		
