'' examples/manual/udt/step-fraction-iterator.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpStep
'' --------

Type fraction
	'' Used to build a step var
	Declare Constructor( ByVal n As Integer, ByVal d As Integer )

	'' Implicit step versions
	Declare Operator For ( )
	Declare Operator Step( )
	Declare Operator Next( ByRef end_cond As fraction ) As Integer

	'' Explicit step versions
	Declare Operator For ( ByRef step_var As fraction )
	Declare Operator Step( ByRef step_var As fraction )
	Declare Operator Next( ByRef end_cond As fraction, ByRef step_var As fraction ) As Integer

	'' Give the current "value"    
	Declare Operator Cast( ) As Double
	Declare Operator Cast( ) As String

	Private:
		As Integer num, den
End Type

Constructor fraction( ByVal n As Integer, ByVal d As Integer )
	this.num = n : this.den = d
End Constructor

Operator fraction.cast( ) As Double
	Operator = num / den
End Operator

Operator fraction.cast( ) As String
	Operator = num & "/" & den
End Operator

'' Some fraction functions
Function gcd( ByVal n As Integer, ByVal m As Integer ) As Integer
	Dim As Integer t
		While m <> 0
			t = m
			m = n Mod m
			n = t
		Wend
	Return n
End Function

Function lcd( ByVal n As Integer, ByVal m As Integer ) As Integer
	Return (n * m) / gcd( n, m )
End Function

''
'' Implicit step versions
'' 
'' In this example, we interpret implicit step
'' to mean 1
''
Operator fraction.for( )
	Print "implicit step"
End Operator

Operator fraction.step( )
	Var lowest = lcd( this.den, 1 )

	Var mult_factor = this.den / lowest
	Dim As fraction step_temp = fraction( 1, 1 )
	
	this.num *= mult_factor
	this.den *= mult_factor
	
	step_temp.num *= lowest
	step_temp.den *= lowest
	
	this.num += step_temp.num
End Operator 

Operator fraction.next( ByRef end_cond As fraction ) As Integer
	Return This <= end_cond
End Operator

''
'' Explicit step versions
'' 
Operator fraction.for( ByRef step_var As fraction )
	Print "explicit step"
End Operator

Operator fraction.step( ByRef step_var As fraction )
	Var lowest = lcd( this.den, step_var.den )
	Var mult_factor = this.den / lowest
	Dim As fraction step_temp = step_var

	this.num *= mult_factor
	this.den *= mult_factor

	mult_factor = step_temp.den / lowest

	step_temp.num *= mult_factor
	step_temp.den *= mult_factor

	this.num += step_temp.num
End Operator 

Operator fraction.next( ByRef end_cond As fraction, ByRef step_var As fraction ) As Integer
	If(( step_var.num < 0 ) Or ( step_var.den < 0 ) ) Then
		Return This >= end_cond
	Else
		Return This <= end_cond
	End If
End Operator

For i As fraction = fraction(1,1) To fraction(4,1)
	Print i; " ";
Next
Print "done"

For i As fraction = fraction(1,4) To fraction(1,1) Step fraction(1,4)
	Print i; " ";
Next
Print "done"

For i As fraction = fraction(4,4) To fraction(1,4) Step fraction(-1,4)
	Print i; " ";
Next
Print "done"

For i As fraction = fraction(4,4) To fraction(1,4)
	Print i; " ";
Next
Print "done"
