'' examples/manual/proguide/opovld/global-ops.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgOperatorOverloading
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
