'' examples/manual/udt/step-char-iterator.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator Step (Iteration)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpStep
'' --------

Type CharIterator
	'' used to build a step var
	Declare Constructor( ByVal r As ZString Ptr )
	
	'' implicit step versions
	Declare Operator For ( )
	Declare Operator Step( )
	Declare Operator Next( ByRef end_cond As CharIterator ) As Integer
	
	'' explicit step versions
	Declare Operator For ( ByRef step_var As CharIterator )
	Declare Operator Step( ByRef step_var As CharIterator )
	Declare Operator Next( ByRef end_cond As CharIterator, ByRef step_var As CharIterator ) As Integer
	
	'' give the current "value"    
	Declare Operator Cast( ) As String
	
	Private:	
		'' data
		value As String
		
		'' This member isn't necessary - we could use
		'' the step variable on each iteration - 
		'' but we choose this method, since we have
		'' to compare strings otherwise. See below.
		is_up As Integer
End Type

Constructor CharIterator( ByVal r As ZString Ptr )
	value = *r
End Constructor

Operator CharIterator.cast( ) As String
	Operator = value
End Operator

'' implicit step versions
'' 
'' In this example, we interpret implicit step
'' to always mean 'up'
Operator CharIterator.for( )
	Print "implicit step"
End Operator

Operator CharIterator.step( )
	value[0] += 1
End Operator 

Operator CharIterator.next( ByRef end_cond As CharIterator ) As Integer
	Return this.value <= end_cond.value
End Operator

'' explicit step versions
'' 
'' In this example, we calculate the direction
'' at FOR, but since the step var is passed to
'' each operator, we have the choice to also calculate
'' it "on-the-fly". For strings such as this, repeated comparison
'' may penalize, but if you're working with simpler types,
'' then you may prefer to avoid the overhead of 
'' an 'is_up' variable.
Operator CharIterator.for( ByRef step_var As CharIterator )
	Print "explicit step"
	is_up = (step_var.value = "up")
End Operator

Operator CharIterator.step( ByRef step_var As CharIterator )
	If( is_up ) Then
		value[0] += 1
	Else
		value[0] -= 1
	End If
End Operator 

Operator CharIterator.next( ByRef end_cond As CharIterator, ByRef step_var As CharIterator ) As Integer
	If( this.is_up ) Then
		Return this.value <= end_cond.value
	Else
		Return this.value >= end_cond.value
	End If
End Operator

For i As CharIterator = "a" To "z"
	Print i; " ";
Next
Print "done"

For i As CharIterator = "a" To "z" Step "up"
	Print i; " ";
Next
Print "done"

For i As CharIterator = "z" To "a" Step "down"
	Print i; " ";
Next
Print "done"

For i As CharIterator = "z" To "a" Step "up"
	Print i; " ";
Next
Print "done"
	
