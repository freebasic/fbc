'' iterator (FOR..NEXT) example

type fraction
	'' used to build a step var
	declare constructor( byval n as integer, byval d as integer )
	
	'' implicit step versions
	declare operator for ( )
	declare operator step( )
	declare operator next( byref end_cond as fraction ) as integer
    
    '' explicit step versions
	declare operator for ( byref step_var as fraction )
	declare operator step( byref step_var as fraction )
	declare operator next( byref end_cond as fraction, byref step_var as fraction ) as integer
    
	'' give the current "value"    
	declare operator cast( ) as double
	declare operator cast( ) as string
	
	private:	
		as integer num, den
		
end type

constructor fraction( byval n as integer, byval d as integer )
	this.num = n : this.den = d
end constructor

operator fraction.cast( ) as double
	operator = num / den
end operator

operator fraction.cast( ) as string
	operator = num & "/" & den
end operator


'' some fraction funcs
Function gcd( Byval n As Integer, Byval m As Integer ) As Integer
    Dim As Integer t
        While m <> 0
                t = m
                m = n Mod m
                n = t
        Wend
    Return n
End Function

Function lcd( Byval n As Integer, Byval m As Integer ) As Integer
    Return (n * m) / gcd( n, m )
End Function

'' implicit step versions
'' 
'' In this example, we interpret implicit step
'' to mean 1
operator fraction.for( )
    print "implicit step"
end operator

operator fraction.step( )
	var lowest = lcd( this.den, 1 )

	var mult_factor = this.den / lowest
	dim as fraction step_temp = fraction( 1, 1 )
	
	this.num *= mult_factor
	this.den *= mult_factor
	
	step_temp.num *= lowest
	step_temp.den *= lowest
	
	this.num += step_temp.num
end operator 

operator fraction.next( byref end_cond as fraction ) as integer
	return this <= end_cond
end operator


'' explicit step versions
'' 
operator fraction.for( byref step_var as fraction )
    print "explicit step"
end operator

operator fraction.step( byref step_var as fraction )
	
	var lowest = lcd( this.den, step_var.den )
	var mult_factor = this.den / lowest
	dim as fraction step_temp = step_var
	
	this.num *= mult_factor
	this.den *= mult_factor
	
	mult_factor = step_temp.den / lowest
	
	step_temp.num *= mult_factor
	step_temp.den *= mult_factor
	
	this.num += step_temp.num
	
end operator 

operator fraction.next( byref end_cond as fraction, byref step_var as fraction ) as integer
	if(( step_var.num < 0 ) or ( step_var.den < 0 ) ) then
		return this >= end_cond
	else
		return this <= end_cond
	end if
end operator


sub test_implicit_step
	for i as fraction = fraction(1,1) to fraction(4,1)
		print i; " ";
	next
	print "done"
end sub	

sub test_explicit_step_up
	for i as fraction = fraction(1,4) to fraction(1,1) step fraction(1,4)
		print i; " ";
	next
	print "done"
end sub	

sub test_explicit_step_down
	for i as fraction = fraction(4,4) to fraction(1,4) step fraction(-1,4)
		print i; " ";
	next
	print "done"
end sub	

sub test_early_out
	for i as fraction = fraction(4,4) to fraction(1,4)
		print i; " ";
	next
	print "done"
end sub	

	test_implicit_step
	test_explicit_step_up
	test_explicit_step_down
	test_early_out
