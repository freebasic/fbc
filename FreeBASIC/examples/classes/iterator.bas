'' iterator (FOR..NEXT) example

type foo
	declare constructor( byval r as zstring ptr )
	
	declare operator for ( )
	declare operator for ( byref stp as foo )
	declare operator step( )
	declare operator step( byref stp as foo )
	declare operator next( byref end_cond as foo ) as integer

	declare function test( byref end_cond as foo ) as integer
	
	declare operator cast( ) as string
	
	
private:	
	value as string
	is_up as integer
end type

constructor foo( byval r as zstring ptr )
	value = *r
end constructor

operator foo.for( )
    
    print "implicit step"
    
    is_up = -1

end operator

operator foo.for( byref stp as foo )
    
    print "explicit step"
    
    '' initialization
	is_up = (stp.value = "up")
	
end operator

operator foo.step( )

	'' increment
	value[0] += 1

end operator 

operator foo.step( byref end_cond as foo )

	'' increment
	if( is_up ) then
		value[0] += 1
	else
		value[0] -= 1
	end if

end operator 

operator foo.next( byref end_cond as foo ) as integer
	
	'' test
	if( this.is_up ) then
		return this.value <= end_cond.value
	else
		return this.value >= end_cond.value
	end if
	
end operator

operator foo.cast( ) as string
	operator = value
end operator

sub test_implicit_step
	for i as foo = "a" to "z"
		print i; " ";
	next
	print "done"
end sub	

	test_implicit_step

sub test_explicit_step_up
	for i as foo = "a" to "z" step "up"
		print i; " ";
	next
	print "done"
end sub	

	test_explicit_step_up

sub test_explicit_step_down
	for i as foo = "z" to "a" step "down"
		print i; " ";
	next
	print "done"
end sub	

	test_explicit_step_down

sub test_early_out
	for i as foo = "z" to "a" step "up"
		print i; " ";
	next
	print "done"
end sub	

	test_early_out


