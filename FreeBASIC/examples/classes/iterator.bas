'' iterator (FOR..NEXT) example

type foo
	declare constructor( byval r as zstring ptr )
	
	declare operator for ( byref end_cond as foo, byref stp as foo ) as integer 
	declare operator for ( byref end_cond as foo ) as integer 

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

function foo.test( byref end_cond as foo ) as integer

	if( this.is_up ) then
		function = this.value <= end_cond.value
	else
		function = this.value >= end_cond.value
	end if

end function

    
operator foo.for( byref end_cond as foo, byref stp as foo ) as integer
    
    print "explicit step"
    
    '' initialization
	is_up = (stp.value = "up")
	
	'' initial test
	return this.test( end_cond )

end operator

operator foo.for( byref end_cond as foo ) as integer
    
    print "implicit step"

    '' initialization
	is_up = -1
	
	'' initial test
	return this.test( end_cond )

end operator

operator foo.next( byref end_cond as foo ) as integer
	
	'' increment
	if( is_up ) then
		value[0] += 1
	else
		value[0] -= 1
	end if
	
	'' test
	return this.test( end_cond )
	
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


