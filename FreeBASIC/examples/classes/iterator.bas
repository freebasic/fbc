'' iterator (FOR..NEXT) example

type foo
	'' used to build a step var
	declare constructor( byval r as zstring ptr )
	
	'' implicit step versions
	declare operator for ( )
	declare operator step( )
	declare operator next( byref end_cond as foo ) as integer
    
    '' explicit step versions
	declare operator for ( byref step_var as foo )
	declare operator step( byref step_var as foo )
	declare operator next( byref end_cond as foo, byref step_var as foo ) as integer
    
	'' give the current "value"    
	declare operator cast( ) as string
	
	private:	
		'' data
		value as string
		
		'' This member isn't necessary - we could use
		'' the step variable on each iteration - 
		'' but we choose this method, since we have
		'' to compare strings otherwise. See below.
		is_up as integer
		
end type

constructor foo( byval r as zstring ptr )
	value = *r
end constructor

operator foo.cast( ) as string
	operator = value
end operator


'' implicit step versions
'' 
'' In this example, we interpret implicit step
'' to always mean 'up'
operator foo.for( )
    print "implicit step"
end operator

operator foo.step( )
	value[0] += 1
end operator 

operator foo.next( byref end_cond as foo ) as integer
	return this.value <= end_cond.value
end operator


'' explicit step versions
'' 
'' In this example, we calculate the direction
'' at FOR, but since the step var is passed to
'' each operator, we have the choice to also calculate
'' it "on-the-fly". For strings such as this, repeated comparison
'' may penalize, but if you're working with simpler types,
'' then you may prefer to avoid the overhead of 
'' an 'is_up' variable.
operator foo.for( byref step_var as foo )
    print "explicit step"
	is_up = (step_var.value = "up")
end operator

operator foo.step( byref step_var as foo )
	if( is_up ) then
		value[0] += 1
	else
		value[0] -= 1
	end if
end operator 

operator foo.next( byref end_cond as foo, byref step_var as foo ) as integer
	if( this.is_up ) then
		return this.value <= end_cond.value
	else
		return this.value >= end_cond.value
	end if
end operator

sub test_implicit_step
	for i as foo = "a" to "z"
		print i; " ";
	next
	print "done"
end sub	

sub test_explicit_step_up
	for i as foo = "a" to "z" step "up"
		print i; " ";
	next
	print "done"
end sub	

sub test_explicit_step_down
	for i as foo = "z" to "a" step "down"
		print i; " ";
	next
	print "done"
end sub	

sub test_early_out
	for i as foo = "z" to "a" step "up"
		print i; " ";
	next
	print "done"
end sub	

	test_implicit_step
	test_explicit_step_up
	test_explicit_step_down
	test_early_out
