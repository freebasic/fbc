'' examples/manual/proguide/iterators/fraction.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Iterators'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeIterators
'' --------

Type fraction
	' user interface
		Declare Constructor (ByVal n As Integer, ByVal d As Integer)
		Declare Operator Cast () As String
	' overload iteration operators when Step is defined in For...Next statement
		Declare Operator For (ByRef iterateStep As fraction)
		Declare Operator Next (ByRef iterateCondition As fraction, ByRef iterateStep As fraction) As Integer
		Declare Operator Step (ByRef step_var As fraction)
	' internal variables and cast operator
		As Integer num, den
		Declare Operator Cast () As Double
End Type

Constructor fraction (ByVal n As Integer, ByVal d As Integer)
	this.num = n
	this.den = d
End Constructor

Operator fraction.Cast () As String
	' search for the highest common factor (a) between numerator and denominator
		Dim As Integer a = Abs(This.num), b = Abs(This.den)
		If a <> 0 Then
			While a <> b 
				If a > b Then
					a -= b
				Else
					b -= a
				End If
			Wend
		Else
			a = 1
		End If
	' reduce the fraction
		Return num \ a & "/" & den \ a
End Operator

Operator fraction.Cast () As Double
	Return This.num / This.den
End Operator

Operator fraction.For (ByRef iterateStep As fraction)
	' search for the least common multiple (a) between the two denominators
		Dim As Integer a = Abs(This.den), b = Abs(iterateStep.den), c = a, d = b
		While a <> b
			If a > b Then
				b += d
			Else
				a += c
			End If
		Wend
	' align at the same denominator the 2 fractions
		This.num *= a \ This.den
		This.den = a
		iterateStep.num *= a \ iterateStep.den
		iterateStep.den = a
End Operator

Operator fraction.Next (ByRef iterateCondition As fraction, ByRef iterateStep As fraction) As Integer
	If iterateStep.num < 0 Or iterateStep.den < 0 Then
		Return This >= iterateCondition
	Else
		Return This <= iterateCondition
	End If
End Operator

Operator fraction.Step (ByRef iterateStep As fraction)
	This.num += iterateStep.num
End Operator 


Print "iteration from 1/8 to 1/2 by step of 1/12:"
For iterator As fraction = fraction(1, 8) To fraction(1, 2) Step fraction(1, 12)
	Print "    " & iterator;
Next
Print
Print
Print "iteration from 7/10 to -8/5 by step of -8/15:"
For iterator As fraction = fraction(7, 10) To fraction(-8, 5) Step fraction(-8, 15)
	Print "    " & iterator;
Next
Print

Sleep
		
